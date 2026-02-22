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
    final contactResult = await _trustedContactRepository.fetchContacts();
    _trustedContacts = contactResult;
    notifyListeners();
  }
  
}