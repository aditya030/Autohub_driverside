import 'dart:async';
import 'dart:convert';
import 'package:autohub_driverside/components/const.dart';
import 'package:autohub_driverside/components/network_utility.dart';
import 'package:autohub_driverside/models/place_details_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; 
import 'package:autohub_driverside/styles/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:latlong2/latlong.dart';
class MapRidePricePage extends StatefulWidget {
  const MapRidePricePage({Key? key}) : super(key: key);

  @override
  State<MapRidePricePage> createState() => _MapRidePricePageState();
}

class _MapRidePricePageState extends State<MapRidePricePage> {
  bool isPremiumSelected = true;
  bool isOnline = true;
  late GoogleMapController mapController;
  Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  LatLng? _pCurrentLocation;
  
  // To get the place latitude and longitude
  Future<LatLng?> getPlaceDetails(String placeId) async {
    Uri uri = Uri.https("maps.googleapis.com", "maps/api/place/details/json", {
      "place_id": placeId,
      "key": GoogleApiKey,
    });
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceDetailsResponse result =
          PlaceDetailsResponse.parsePlaceDetailsResult(response);
      if (result.result != null) {
        final location = result.result!.geometry!.location;
        return LatLng(location!.lat, location.lng);
      }
    }
    return null;
  }
  
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  
  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          _pCurrentLocation == null
              ? Center(
                  child: Image.asset(
                    'assets/icons/loading_animation.gif',
                    width: screenHeight * 0.3,
                  ),
                )
              : GoogleMap(
                  onMapCreated: ((GoogleMapController controller) {
                    _mapController.complete(controller);
                    mapController = controller;
                  }),
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: _pCurrentLocation!, zoom: 13),
                  markers: {
                    if (_pCurrentLocation != null)
                      Marker(
                        markerId: MarkerId("_currentLocation"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(90),
                        position: _pCurrentLocation!,
                      ),
                  },
                  // polylines: Set<Polyline>.of(polylines.values),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isOnline = !isOnline; // Toggle online/offline status
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isOnline ? Colors.green : Colors.grey,
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_taxi,
                        color: isOnline ? Colors.green : Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        isOnline ? "Online" : "Offline",
                        style: TextStyle(
                          color: isOnline ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                ClipOval(
                  child: Image.asset(
                    "assets/images/user2.png",
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.42,
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Choose your ride",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0),
                  RideOption(
                    title: "Auto",
                    subtitle: "2-3 person",
                    price: "₹ 14/km",
                    isSelected: !isPremiumSelected,
                    onTap: () {
                      if (!isOnline) {
                        _showToast("Please switch to online mode.");
                        return;
                      }
                      setState(() {
                        isPremiumSelected = false;
                      });
                    },
                    isClickable: isOnline,
                  ),
                  RideOption(
                    title: "Premium Auto",
                    subtitle: "4-5 person",
                    price: "₹ 18/km",
                    isSelected: isPremiumSelected,
                    onTap: () {
                      if (!isOnline) {
                        _showToast("Please switch to online mode.");
                        return;
                      }
                      setState(() {
                        isPremiumSelected = true;
                      });
                    },
                    isClickable: isOnline,
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!isOnline) {
                          _showToast("Please switch to online mode.");
                          return;
                        }
                        Navigator.pushNamed(context, '/bidpage1');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Riding",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _locationPermissionGranted;

    // If Location is disabled send a prompt saying to turn on the location.
    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
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
          _pCurrentLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          print("Current Position: $currentLocation");
        });
      }
    });
  }

}

class RideOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isClickable; // Add this parameter

  const RideOption({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    required this.onTap,
    required this.isClickable, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff70D94C) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              price,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
