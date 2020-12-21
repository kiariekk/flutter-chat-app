import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/entities/send_location_params.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';
import 'package:flutter_chat_app/core/services/location_service.dart';
import 'package:flutter_chat_app/core/usecases/usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SendLocation extends Usecase<SendLocationParams, void> {
  final LocationService locationService;
  final DatabaseService databaseService;

  const SendLocation.singleton({
    @required this.locationService,
    @required this.databaseService,
  });

  @override
  Future<void> call(SendLocationParams params) async {
    if (!await _hasPermissionsAfterRequestingIfNeeded()) return;
    final locationData = await locationService.getLocation();
    await databaseService.sendLocationMessage(
      coords: LatLng(locationData.latitude, locationData.longitude),
      receiverEmail: params.receiverEmail,
      chat: params.chatDoc,
    );
  }

  Future<bool> _hasPermissionsAfterRequestingIfNeeded() async {
    if (!locationService.isEnabled) {
      await locationService.requestToEnable();
      if (!locationService.isEnabled) return false;
    }
    if (!locationService.hasPermission) {
      await locationService.requestPermission();
      if (!locationService.hasPermission) return false;
    }
    return true;
  }
}
