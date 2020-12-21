import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/entities/stream_location_params.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';
import 'package:flutter_chat_app/core/services/location_service.dart';
import 'package:flutter_chat_app/core/usecases/usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class StreamLocation extends Usecase<StreamLocationParams, void> {
  final DatabaseService databaseService;
  final LocationService locationService;

  StreamLocation({
    @required this.databaseService,
    @required this.locationService,
  });

  StreamSubscription<LocationData> _locationSubscription;

  @override
  void call(StreamLocationParams params) async {
    if (_locationSubscription == null) {
      _locationSubscription = locationService.onLocationChanged.listen(
        (LocationData data) async {
          await _onLocationChangeHandler(data, params.documentReference);
        },
      );
    }
  }

  Future<void> _onLocationChangeHandler(
    LocationData data,
    DocumentReference documentReference,
  ) async {
    await databaseService.updateLocationMessage(
      documentReference: documentReference,
      coords: LatLng(data.latitude, data.longitude),
    );
  }

  Future<void> cancel() async {
    await _locationSubscription.cancel();
    _locationSubscription = null;
  }
}
