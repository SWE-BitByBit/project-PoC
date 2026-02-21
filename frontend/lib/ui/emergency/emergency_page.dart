import 'contact.dart';
import 'package:flutter/material.dart';

import '../emergency/view_model/view_model_trusted_contacts.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key, required this.viewModel});

  final ViewModelTrustedContacts viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatti fidati'),
      ),
      body: ListView.builder(
        itemCount: viewModel.trustedContact.lenght;
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