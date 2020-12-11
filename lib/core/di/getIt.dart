import 'package:flutter_chat_app/presentation/blocs/add_contact/add_contact_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class GetItUtils {
  const GetItUtils._();

  static Future<void> setup() async {
    getIt.registerFactory<AddContactBloc>(
      () => AddContactBloc(),
    );
  }
}
