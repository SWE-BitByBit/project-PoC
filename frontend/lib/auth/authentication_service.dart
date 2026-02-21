import 'dart:convert';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class AuthenticationService {
  static final AuthenticationService _instance = AuthenticationService._internal();
  static AuthenticationService get instance => _instance;

  User? _currentUser;
  User? getCurrentUser() => _currentUser;

  final String _cognitoDomain = 'eu-north-1vf1mmfpoo.auth.eu-north-1.amazoncognito.com';
  final String _clientId = '5dlcoa478c3uve9bctpopae4kl';
  final String _clientSecret = '1cdda1dn6k8900h56bs6eimdbf7kbsk99sgdl7oltsf11klondnq';
  final String _redirectUri = 'com.bitbybit.appcheproteggeetrasforma://callback';
  final List<String> _scopes = ['profile', 'email', 'openid'];

  AuthenticationService._internal();

  // Login Google tramite Cognito
  Future<User?> loginWithGoogle() async {
    try {
      final authUrl = Uri.https(_cognitoDomain, '/oauth2/authorize', {
        'response_type': 'code',
        'client_id': _clientId,
        'redirect_uri': _redirectUri,
        'scope': _scopes.join(' '),
        'identity_provider': 'Google',
        'lang': 'it',
        'prompt': 'select_account',
      });

      final result = await FlutterWebAuth2.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: "com.bitbybit.appcheproteggeetrasforma",
      );
      
      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) throw Exception('Authorization code mancante');

      final basicAuth = base64Encode(
        utf8.encode('$_clientId:$_clientSecret'),
      );

      final tokenResponse = await http.post(
        Uri.https(_cognitoDomain, '/oauth2/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic $basicAuth',
        },
        body: {
          'grant_type': 'authorization_code',
          'client_id': _clientId,
          'code': code,
          'redirect_uri': _redirectUri,
        },
      );

      if (tokenResponse.statusCode != 200) {
        throw Exception('Token error: ${tokenResponse.body}');
      }

      final tokens = jsonDecode(tokenResponse.body);

      final idToken = tokens['id_token'];
      final accessToken = tokens['access_token'];
      final refreshToken = tokens['refresh_token'];

      if (idToken == null || accessToken == null) {
        throw Exception('Token mancanti');
      }
      
      final user = User.fromIdToken(idToken, accessToken, refreshToken);
      _currentUser = user;
      return user;

    } catch (e) {
      print('Errore di login: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    final url = Uri.https(_cognitoDomain, '/logout', {
      'client_id': _clientId,
      'logout_uri': _redirectUri,
    });
    try {
      await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: "com.bitbybit.appcheproteggeetrasforma",
      );
    } catch (e) {
      print('Errore di logout: $e');
    }
  }

  bool isUserLoggedIn() {
    return _currentUser != null && _currentUser!.sub != null;
  }
}
