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

  Future<void> _defaultLogin() async {
    if (_formKey.currentState!.validate()) {
      final auth = AuthenticationService.instance;
      final user = await auth.loginWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null && mounted) {
        // Utente autenticato con email / password
      }
    }
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
                  const SizedBox(height: 32),
                  _EmailField(controller: _emailController),
                  const SizedBox(height: 16),
                  _PasswordField(controller: _passwordController),
                  const SizedBox(height: 24),
                  _LoginButton(onPressedCallback: _defaultLogin),
                  const SizedBox(height: 24),
                  const _DividerWithText(),
                  const SizedBox(height: 24),
                  _GoogleLoginButton(onPressedCallback: _googleLogin),
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

class _EmailField extends StatelessWidget {
  final TextEditingController controller;
  const _EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Inserisci un\'email';
        }
        return null;
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock_outline),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Inserisci una password';
        }
        return null;
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onPressedCallback;
  const _LoginButton({required this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedCallback,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: const Text(
        'Login',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

// Divisore tra login normale e login Google
class _DividerWithText extends StatelessWidget {
  const _DividerWithText();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('oppure'),
        ),
        Expanded(child: Divider()),
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
      icon: const Icon(Icons.login),
      label: const Text('Accedi con Google'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}