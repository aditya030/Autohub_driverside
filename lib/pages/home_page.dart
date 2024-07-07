import 'package:autohub_driverside/components/text_field_style.dart';
import 'package:autohub_driverside/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPremiumSelected = true;
  bool isOnline = true; // Add this variable

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
           FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(12.9692, 79.1559),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.vit.vellore',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(12.9692, 79.1559),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
  padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center the button
    children: [
      Spacer(), // Add Spacer before the button
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
        child: Text(
          isOnline ? "Online" : "Offline",
          style: TextStyle(
            color: isOnline ? Colors.green : Colors.grey,
          ),
        ),
      ),
      Spacer(), // Add Spacer after the button
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.40,
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 29),
                    child: SizedBox(
                      height: screenHeight * 0.055,
                      width: screenWidth,
                      child: Text(
                        "Choose your ride",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPremiumSelected = false;
                      });
                    },
                    child: Container(
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      color: isPremiumSelected ? AppColors.offwhite : Color(0xff70D94C),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Auto",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  "2-3 Persons",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            "₹ --/km",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPremiumSelected = true;
                      });
                    },
                    child: Container(
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      color: isPremiumSelected ? Color(0xff70D94C) : AppColors.offwhite,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Premium Auto",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  "4-5 Persons",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            "₹ --/km",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isPremiumSelected = !isPremiumSelected; // Toggle selection
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          "Switch Mode",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
}

