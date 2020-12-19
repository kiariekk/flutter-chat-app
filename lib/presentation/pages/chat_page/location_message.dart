import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/constants/LocationConstants.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/message.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMessage extends StatefulWidget {
  final List<double> coords;
  final bool sendByCurrentUser;

  const LocationMessage({
    Key key,
    @required this.coords,
    @required this.sendByCurrentUser,
  }) : super(key: key);

  static const _initialCameraPos = CameraPosition(
    target: LatLng(-22.5714216, -44.1696647),
    zoom: 14.4,
  );

  @override
  _LocationMessageState createState() => _LocationMessageState();
}

class _LocationMessageState extends State<LocationMessage> {
  GoogleMapController _controller;

  List<LatLng> _routePoints = List<LatLng>();

  @override
  void initState() {
    super.initState();
    PolylinePoints()
        .getRouteBetweenCoordinates(
      LocationConstants.directionsApiKey,
      PointLatLng(-22.5527928, -44.1436984),
      PointLatLng(-22.566158, -44.1377144),
    )
        .then((res) {
      setState(() {
        print(res.errorMessage);
        print(res.points);
        _routePoints =
            res.points.map((p) => LatLng(p.latitude, p.longitude)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _controller.animateCamera(
              CameraUpdate.newLatLng(LatLng(-22.5714216, -44.1896647)),
            );
          },
        ),
        ClipRRect(
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
                  initialCameraPosition: LocationMessage._initialCameraPos,
                  onMapCreated: (controller) => _controller = controller,
                  compassEnabled: false,
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('some id'),
                      color: Colors.red,
                      points: _routePoints,
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('sla'),
                      position: LatLng(-22.5714216, -44.1696647),
                    ),
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
