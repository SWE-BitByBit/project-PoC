import '../../domain/trusted_contact.dart';

class TrustedContactModel extends TrustedContact {
  const TrustedContactModel({
    required super.contactId,
    required super.name,
    required super.email
  });

  factory TrustedContactModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'contact_id': String contactId,
        'name': String name,
        'email': String email
      } => TrustedContactModel(
        contactId: contactId,
        name: name,
        email: email
      ),
      _ => throw const FormatException('Failed to load contact from json.'), 
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'contact_id':contactId,
      'name': name,
      'email': email
    };
  }

}