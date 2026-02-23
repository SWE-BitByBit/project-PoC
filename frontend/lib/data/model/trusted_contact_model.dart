import '../../domain/trusted_contact.dart';

class TrustedContactModel extends TrustedContact {
  const TrustedContactModel({
<<<<<<< HEAD
=======
    required super.userEmail,
>>>>>>> develop
    required super.contactId,
    required super.name,
    required super.email
  });

  factory TrustedContactModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
<<<<<<< HEAD
=======
        'user_email': String userEmail,
>>>>>>> develop
        'contact_id': String contactId,
        'name': String name,
        'email': String email
      } => TrustedContactModel(
<<<<<<< HEAD
=======
        userEmail: userEmail,
>>>>>>> develop
        contactId: contactId,
        name: name,
        email: email
      ),
      _ => throw const FormatException('Failed to load truted contact.'), 
    };
  }

  Map<String, dynamic> toJson() {
    return {
<<<<<<< HEAD
=======
      'user_email': userEmail,
>>>>>>> develop
      'contact_id':contactId,
      'name': name,
      'email': email
    };
  }

}