import 'package:flutter_chat_app/core/services/database_queries.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';
import 'package:flutter_chat_app/core/services/location_service.dart';
import 'package:flutter_chat_app/core/usecases/send_location_message.dart';
import 'package:flutter_chat_app/core/usecases/stream_location.dart';
import 'package:flutter_chat_app/presentation/blocs/add_contact/add_contact_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class GetItUtils {
  const GetItUtils._();

  static Future<void> setup() async {
    getIt.registerSingleton<DatabaseService>(DatabaseService.singleton());
    getIt.registerSingleton<DatabaseQueries>(DatabaseQueries.singleton());
    getIt.registerSingleton<LocationService>(LocationService.singleton());
    getIt.registerFactory<AddContactBloc>(
      () => AddContactBloc(getIt<DatabaseService>()),
    );
    getIt.registerSingleton<SendLocation>(SendLocation.singleton(
      locationService: getIt<LocationService>(),
      databaseService: getIt<DatabaseService>(),
    ));
    getIt.registerFactory<StreamLocation>(
      () => StreamLocation(
        databaseService: getIt<DatabaseService>(),
        locationService: getIt<LocationService>(),
      ),
    );
  }

  static Future<void> initialize() async {
    await Future.wait([
      getIt<DatabaseService>().initialize(),
      getIt<LocationService>().initialize(),
    ]);
  }
}
