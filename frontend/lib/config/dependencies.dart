import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/services/trusted_contact_api.dart';
import '../data/repositories/trusted_contact_repository.dart';
import '../ui/trusted_contacts/view_model/view_model_trusted_contacts.dart';

import '../data/services/note_api.dart';
import '../data/repositories/note_repository.dart';
import '../ui/note/view_model/view_model_notes.dart';

List<SingleChildWidget> appProviders = [
  Provider(
    create: (context) => TrustedContactApi(
      dotenv.env['API_BASE_URL'] ?? '',
    )
  ),
  Provider(
    create: (context) => TrustedContactRepository(
      api: context.read<TrustedContactApi>(),
    ),
  ),
  ChangeNotifierProvider(
      create: (context) => ViewModelTrustedContacts(
      trustedContactRepository: context.read<TrustedContactRepository>()
    ),
  ),
  Provider(
    create: (context) => NoteApi(
      dotenv.env['API_BASE_URL'] ?? '',
    )
  ),
  Provider(
    create: (context) => NoteRepository(
      api: context.read<NoteApi>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => ViewModelNotes(
        noteRepository: context.read<NoteRepository>()
      )
    )
];
