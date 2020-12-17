import 'package:location/location.dart';

class LocationService {
  LocationService.singleton() {
    _isEnabled = false;
  }

  final _location = Location();

  Future<void> initialize() async {
    _permissionStatus = await _location.hasPermission();
    _isEnabled = await _location.serviceEnabled();
  }

  bool get isEnabled => _isEnabled;
  bool _isEnabled;

  bool get hasPermission =>
      _permissionStatus == PermissionStatus.granted ||
      _permissionStatus == PermissionStatus.grantedLimited;
  PermissionStatus get permissionStatus => _permissionStatus;
  PermissionStatus _permissionStatus;

  Future<void> requestToEnable() async {
    _isEnabled = await _location.requestService();
  }

  Future<void> requestPermission() async {
    _permissionStatus = await _location.requestPermission();
  }

  Future<LocationData> getLocation() async {
    return await _location.getLocation();
  }
}
