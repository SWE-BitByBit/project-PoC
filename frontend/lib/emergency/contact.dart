class Contact {
  final String name;
  final String phone;
  final String email;

  Contact({required this.name, required this.phone, required this.email});
}

// Dati di esempio per testare la visualizzazione
final List<Contact> emergencyContacts = [
  Contact(name: 'Piero', phone: '000 000 0000', email: 'piero@example.com'),
  Contact(name: 'Carabinieri', phone: '112', email: 'carabinieri@example.com'),
  Contact(name: 'Vigili del Fuoco', phone: '115', email: 'vigili@example.com'),
  Contact(name: 'Emergenza Infanzia', phone: '114', email: 'infanzia@example.com'),
];
