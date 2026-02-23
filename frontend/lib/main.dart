import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'config/dependencies.dart';

import 'chatbot/chatbot_page.dart';
import 'ui/trusted_contacts/trusted_contacts_page.dart';
import 'auth/auth_page.dart';
import 'ui/trusted_contacts/view_model/view_model_trusted_contacts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              child: const Text("Vai all'autenticazione"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationPage(),
                  )
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Vai ai contatti di emergenza"),
              onPressed: () {
                final viewModel = context.read<ViewModelTrustedContacts>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmergencyPage(viewModel: viewModel),
                  )
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Vai al Chatbot"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatbotPage(),
                  )
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}