import 'package:flutter/material.dart';
import 'authentication_service.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _googleLogin() async {
    if (_formKey.currentState!.validate()) {
      final auth = AuthenticationService.instance;
      final user = await auth.loginWithGoogle();
      if (user != null && mounted) {
        // Utente autenticato con Google
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Header(),
                  const SizedBox(height: 48),
                  _GoogleLoginButton(onPressedCallback: _googleLogin),
                  const SizedBox(height: 16),
                  const Text(
                    'L\'accesso è consentito solo tramite account Google ufficiale.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Icona lucchetto con titolo pagina
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.lock_outline, size: 64),
        SizedBox(height: 16),
        Text(
          'Accedi al tuo account',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressedCallback;
  const _GoogleLoginButton({required this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressedCallback,
      icon: Image.asset(
        'assets/google_logo.jpg',
        height: 24,
      ),
      label: const Text('Accedi con Google'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: Colors.grey),
      ),
    );
  }
}