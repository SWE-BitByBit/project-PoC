import 'contact.dart';
import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatti fidati'),
      ),
      body: ListView.builder(
        itemCount: emergencyContacts.length,
        itemBuilder: (context, index) {
          final contact = emergencyContacts[index];
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.contact_phone),
            ),
            title: Text(contact.name),
            subtitle: Text('${contact.phone} - ${contact.email}'),
          );
        },
      ),
    );
  }
}