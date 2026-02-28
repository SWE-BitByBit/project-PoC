class TrustedContact {
  final String contactId;
  final String name;
  final String email;

  const TrustedContact({
    required this.contactId,
    required this.name,
    required this.email
  });

  factory TrustedContact.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'contact_id': String contactId,
        'name': String name,
        'email': String email
      } => TrustedContact(
        contactId: contactId,
        name: name,
        email: email
      ),
      _ => throw const FormatException('Failed to load contact from json.'), 
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'contact_id': contactId,
      'name': name,
      'email': email
    };
  }
}