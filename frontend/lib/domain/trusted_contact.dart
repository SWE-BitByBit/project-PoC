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
    return TrustedContact(
      contactId: json['contact_id'],
      name: json['name'],
      email: json['email']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contact_id': contactId,
      'name': name,
      'email': email
    };
  }
}