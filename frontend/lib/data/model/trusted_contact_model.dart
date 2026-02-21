import '../../domain/trusted_contact.dart';

class TrustedContactModel extends TrustedContact {
  const TrustedContactModel({
    required super.userEmail,
    required super.contactId,
    required super.name,
    required super.email
  });

  factory TrustedContactModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'user_email': String userEmail,
        'contact_id': String contactId,
        'name': String name,
        'email': String email
      } => TrustedContactModel(
        userEmail: userEmail,
        contactId: contactId,
        name: name,
        email: email
      ),
      _ => throw const FormatException('Failed to load truted contact.'), 
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'user_email': userEmail,
      'contact_id':contactId,
      'name': name,
      'email': email
    };
  }

}