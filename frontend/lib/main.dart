import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'package:flutter_application_1/ui/note/notes_preview_page.dart';
import 'config/dependencies.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'chatbot/chatbot_page.dart';
import 'ui/trusted_contacts/view_model/view_model_trusted_contacts.dart';
import 'package:flutter_application_1/ui/note/view_model/view_model_notes.dart';
import 'auth/auth_page.dart';
import 'package:flutter_application_1/ui/trusted_contacts/trusted_contacts_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
              child: const Text("Vai alle note"),
              onPressed: () {
                final viewModelNotes = context.read<ViewModelNotes>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesPage(viewModel: viewModelNotes),
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