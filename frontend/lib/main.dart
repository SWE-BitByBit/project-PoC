import 'package:flutter/material.dart';
import 'package:flutter_application_1/emergency/emergency_page.dart';
import 'auth/auth_page.dart';
import 'chatbot/chatbot_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
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
          mainAxisAlignment: .center,
          children: [
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

            ElevatedButton(
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
            
            ElevatedButton(
              child: const Text("Vai ai contatti di emergenza"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmergencyPage(),
                  )
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
