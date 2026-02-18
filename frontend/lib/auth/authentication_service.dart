import 'dart:convert';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

/// Rappresenta un utente autenticato
class User {
  final String username;
  final String email;
  final String idToken;
  final String accessToken;
  final String? refreshToken;

  User({
    required this.username,
    required this.email,
    required this.idToken,
    required this.accessToken,
    this.refreshToken,
  });

  factory User.fromIdToken(String idToken, String accessToken, [String? refreshToken]) {
    // Decodifica payload JWT (base64 url)
    final parts = idToken.split('.');
    if (parts.length != 3) throw Exception('ID token non valido');

    final payload = base64Url.normalize(parts[1]);
    final decoded = utf8.decode(base64Url.decode(payload));
    final data = jsonDecode(decoded);

    return User(
      username: data['cognito:username'] ?? data['sub'] ?? '',
      email: data['email'] ?? '',
      idToken: idToken,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

class AuthenticationService {
  static final AuthenticationService _instance = AuthenticationService._internal();
  static AuthenticationService get instance => _instance;

  User? _currentUser;
  User? get currentUser => _currentUser;

  final String _cognitoDomain = 'eu-north-1vf1mmfpoo.auth.eu-north-1.amazoncognito.com';
  final String _clientId = '1tgc8sh9883mnlkc9650l07l1v';
  final String _redirectUri = 'myapp://auth/';
  final List<String> _scopes = ['openid', 'email', 'phone'];

  AuthenticationService._internal();

  /// Login Google tramite Cognito Hosted UI
  Future<User?> loginWithGoogle() async {
    try {
      // Costruzione URL hosted UI
      final url = Uri.https(_cognitoDomain, '/login', {
        'response_type': 'code',
        'client_id': _clientId,
        'redirect_uri': _redirectUri,
        'scope': _scopes.join(' '),
        'identity_provider': 'Google',
        'lang' : 'it',
      });

      // Apri browser per login e intercetta redirect
      final result = await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: _redirectUri.split('://')[0],
      );

      // Estrai code dall'URL di redirect
      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) throw Exception('Codice di autorizzazione mancante');

      // Scambia code con token Cognito
      final tokenResponse = await http.post(
        Uri.https(_cognitoDomain, '/oauth2/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'client_id': _clientId,
          'code': code,
          'redirect_uri': _redirectUri,
        },
      );

      if (tokenResponse.statusCode != 200) {
        throw Exception('Errore durante lo scambio token: ${tokenResponse.body}');
      }

      final tokens = jsonDecode(tokenResponse.body);
      final idToken = tokens['id_token'] as String?;
      final accessToken = tokens['access_token'] as String?;
      final refreshToken = tokens['refresh_token'] as String?;

      if (idToken == null || accessToken == null) {
        throw Exception('Token mancanti nella risposta Cognito');
      }

      _currentUser = User.fromIdToken(idToken, accessToken, refreshToken);
    } catch (e) {
      print('Errore login Hosted UI: $e');
      return null;
    }
  }

  /// Logout
  Future<void> logout() async {
    _currentUser = null;
    final url = Uri.https(_cognitoDomain, '/logout', {
      'client_id': _clientId,
      'logout_uri': _redirectUri,
    });
    try {
      await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: _redirectUri.split('://')[0],
      );
    } catch (_) {
      // Ignora errori logout browser
    }
  }
}
