import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/entities/stream_location_params.dart';
import 'package:flutter_chat_app/core/usecases/stream_location.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/message.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMessage extends StatefulWidget {
  final DocumentReference documentRef;
  final LatLng coords;
  final bool sendByCurrentUser;

  const LocationMessage({
    Key key,
    @required this.coords,
    @required this.sendByCurrentUser,
    @required this.documentRef,
  }) : super(key: key);

  @override
  _LocationMessageState createState() => _LocationMessageState();
}

class _LocationMessageState extends State<LocationMessage> {
  GoogleMapController _mapController;
  StreamLocation _streamLocation;

  @override
  void initState() {
    super.initState();
    if (widget.sendByCurrentUser) {
      _streamLocation = getIt<StreamLocation>();
      _streamLocation.call(StreamLocationParams(widget.documentRef));
    }
  }

  @override
  Widget build(BuildContext context) {
    _atualizeMapPosIfNeeded();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Message(
        sendByCurrentUser: widget.sendByCurrentUser,
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 300,
            height: 300,
            child: GoogleMap(
              mapType: MapType.normal,
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: CameraPosition(
                zoom: 14,
                target: widget.coords,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('current_sender_location'),
                  position: widget.coords,
                ),
              },
              compassEnabled: false,
            ),
          ),
        ),
      ),
    );
  }

  void _atualizeMapPosIfNeeded() {
    if (_mapController == null) return;
    _mapController.animateCamera(CameraUpdate.newLatLng(widget.coords));
  }

  @override
  void dispose() {
    if (_streamLocation != null) {
      _streamLocation.cancel();
    }
    super.dispose();
  }
}
