import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/model/trusted_contact_model.dart';
<<<<<<< HEAD
import '../../auth/authentication_service.dart';
=======
>>>>>>> develop

class TrustedContactApi {

  final String baseUrl;

  TrustedContactApi(this.baseUrl);

  Future<List<TrustedContactModel>> fetchContacts() async {
<<<<<<< HEAD
    final user = AuthenticationService.instance.getCurrentUser();

    if (user == null) throw Exception("Utente non autenticato");


=======
>>>>>>> develop
    final response = await http.get(
        Uri.parse('$baseUrl/contacts'),
        headers: {
          'Content-Type': 'application/json',
<<<<<<< HEAD
          'Authorization': 'Bearer ${user.accessToken}',
=======
>>>>>>> develop
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
<<<<<<< HEAD
      throw Exception('Failed to load trusted contacts');
=======
      throw Exception('Failed to load album');
>>>>>>> develop
    }
  }


  Future<TrustedContactModel> createContact(String name, String email) async {
<<<<<<< HEAD
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

=======
>>>>>>> develop
    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
      headers: {
        'Content-Type': 'application/json',
<<<<<<< HEAD
        'Authorization': 'Bearer ${user.accessToken}',
=======
>>>>>>> develop
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
<<<<<<< HEAD
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.delete(
      Uri.parse('$baseUrl/contacts/$id'),
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
      },
=======
    final response = await http.delete(
      Uri.parse('$baseUrl/contacts/$id')
>>>>>>> develop
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete contact');
    }
  }
}