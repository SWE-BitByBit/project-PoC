import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/services/trusted_contact_api.dart';
import '../data/repositories/trusted_contact_repository.dart';
import '../ui/trusted_contacts/view_model/view_model_trusted_contacts.dart';

List<SingleChildWidget> appProviders = [
  Provider(
    create: (context) => TrustedContactApi(
      'https://ihnq91q2lk.execute-api.eu-north-1.amazonaws.com',
    )
  ),
  Provider(
    create: (context) => TrustedContactRepository(
      api: context.read<TrustedContactApi>(),
    ),
  ),
  ChangeNotifierProvider(create: (context) => ViewModelTrustedContacts(
      trustedContactRepository: context.read<TrustedContactRepository>()
    ),
  ),
];
