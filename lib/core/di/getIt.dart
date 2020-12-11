import 'package:flutter_chat_app/core/services/database_service.dart';
import 'package:flutter_chat_app/presentation/blocs/add_contact/add_contact_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class GetItUtils {
  const GetItUtils._();

  static Future<void> setup() async {
    getIt.registerSingleton<DatabaseService>(DatabaseService());
    getIt.registerFactory<AddContactBloc>(
      () => AddContactBloc(getIt<DatabaseService>()),
    );
  }
}
