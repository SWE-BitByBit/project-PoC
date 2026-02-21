import '../../domain/trusted_contact.dart';
import '../../data/services/trusted_contact_api.dart';

class TrustedContactRepository {
  final TrustedContactApi _api;

  TrustedContactRepository({
    required TrustedContactApi api,
  }) : _api = api;

  Future<List<TrustedContact>> fetchContacts() {
    return _api.fetchContacts();
  }

  Future<TrustedContact> createContact(String name, String email) {
    return _api.createContact(name, email);
  }

  Future<void> deleteContact(String id) {
    return _api.deleteContact(id);
  }
}
