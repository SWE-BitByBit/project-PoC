import 'dart:convert';

class User {
  String? sub;
  String? name;
  String? surname;
  String? email;
  String? phoneNumber;
  int? age;

  final String idToken;
  final String accessToken;
  final String? refreshToken;

  User({
    this.sub,
    this.name,
    this.surname,
    this.email,
    this.age,
    this.phoneNumber,
    required this.idToken,
    required this.accessToken,
    this.refreshToken,
  });

  User.fromIdToken(String idToken, String accessToken, [String? refreshToken])
    : idToken = idToken,
      accessToken = accessToken,
      refreshToken = refreshToken {
      final parts = idToken.split('.');
      if (parts.length != 3) {
        throw Exception('ID token non valido');
      }

      final payload = base64Url.normalize(parts[1]);
      final decoded = utf8.decode(base64Url.decode(payload));
      final data = jsonDecode(decoded);
      print('JWT payload completo: $data');

      sub = data['sub'];
      email = data['email'];
      name = data['name'];
      surname = data['family_name'];
      age = data['age'];
      phoneNumber = data['phone_number'];
  }

    @override
  String toString() {
    return '''
      User(
        sub: $sub,
        name: $name,
        surname: $surname,
        email: $email,
        age: $age,
        phoneNumber: $phoneNumber,
        idToken: $idToken,
        accessToken: $accessToken,
        refreshToken: $refreshToken
      )
    ''';
  }
}
