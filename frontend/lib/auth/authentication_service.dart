import 'user.dart';

class AuthenticationService {
  static final AuthenticationService _instance = AuthenticationService._internal();
  static AuthenticationService get instance => _instance;

  AuthenticationService._internal();

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<User?> loginWithEmailAndPassword(String email, String password) async {

  }

  Future<User?> loginWithGoogle() async {

  }

  Future<void> logout() async {
    _currentUser = null;
  }
}