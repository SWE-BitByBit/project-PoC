import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/model/trusted_contact_model.dart';
import '../../auth/authentication_service.dart';

class TrustedContactApi {

  final String baseUrl;

  TrustedContactApi(this.baseUrl);

  Future<List<TrustedContactModel>> fetchContacts() async {
    final user = AuthenticationService.instance.getCurrentUser();

    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.get(
        Uri.parse('$baseUrl/contacts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.accessToken}',
        },
      );
    
    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);

      final List<TrustedContactModel> contacts = [];

      for (var item in decoded) {
        final contact = TrustedContactModel.fromJson(item);
        contacts.add(contact);
      }

      return contacts;
    } else {
      throw Exception('Failed to load album');
    }
  }


  Future<TrustedContactModel> createContact(String name, String email) async {
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
      body: jsonEncode(<String,String>{
        'name': name,
        'email': email,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create contact');
    }

    return TrustedContactModel.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteContact(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/contacts/$id')
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete contact');
    }
  }
}