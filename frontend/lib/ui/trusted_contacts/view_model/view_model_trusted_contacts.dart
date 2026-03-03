import '../../../domain/trusted_contact.dart';
import '../../../data/repositories/trusted_contact_repository.dart';
import 'package:flutter/material.dart';

class ViewModelTrustedContacts extends ChangeNotifier{

  ViewModelTrustedContacts({
    required TrustedContactRepository trustedContactRepository,
  }) : _trustedContactRepository = trustedContactRepository {
    _load();
  }

  final TrustedContactRepository _trustedContactRepository;

  List<TrustedContact> _trustedContacts = [];
  List<TrustedContact> get trustedContact => _trustedContacts;

  Future<void> _load() async {
    _trustedContacts = await _trustedContactRepository.fetchContacts();
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await _trustedContactRepository.deleteContact(id);
    _trustedContacts.removeWhere((booking) => booking.contactId == id);
    
    notifyListeners();
  }
  
}