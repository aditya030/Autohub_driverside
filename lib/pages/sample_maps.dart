import 'package:autohub_app/pages/destination_page.dart';
import 'package:autohub_app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SampleMaps extends StatefulWidget {
  const SampleMaps({super.key});

  @override
  State<SampleMaps> createState() => _SampleMapsState();
}

class _SampleMapsState extends State<SampleMaps> {
  Location _locationController = Location();
  LatLng? _currentLocation = null;
  late GoogleMapController mapController;
  static LatLng _pSource = LatLng(12.9692, 79.1559);
  static LatLng _pDestination = LatLng(12.9244, 79.1353);
  @override
  void initState() {
    super.initState();
    getLocationupdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? const Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                ),
              ),
            )
          : GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(target: _pSource, zoom: 18),
              markers: {
                Marker(
                    markerId: MarkerId("_currentLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentLocation!),
                Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pSource),
                Marker(
                    markerId: MarkerId("_destionationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pDestination),
              },
            ),
    );
  }

  Future<void> getLocationupdates() async {
    bool _serviceEnabled;
    PermissionStatus _locationPermissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _locationPermissionGranted = await _locationController.hasPermission();
    if (_locationPermissionGranted == PermissionStatus.denied) {
      _locationPermissionGranted =
          await _locationController.requestPermission();
      if (_locationPermissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          print("Current Position: $currentLocation");
        });
      }
    });
  }
}
