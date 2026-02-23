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
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: viewModel.trustedContact.length,
            itemBuilder: (context, index) {
              final contact = viewModel.trustedContact[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.contact_phone),
                ),
                title: Text(contact.name),
                subtitle:
                    Text(contact.email),
              );
            },
          );
        },
      )
    );
  }
}