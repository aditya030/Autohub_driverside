import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BookingPagem extends StatefulWidget {
  const BookingPagem({Key? key}) : super(key: key);

  @override
  State<BookingPagem> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPagem> {
  bool isOnline = true;

  void toggleOnlineStatus() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
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
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 50.0,
            left: 15.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            top: 50.0,
            right: 15.0,
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/user2.png'),
              radius: 30,
            ),
          ),
          Positioned(
            top: 50.0,
            left: (screenWidth - 160) / 2, // Center the button horizontally
            child: ElevatedButton(
              onPressed: toggleOnlineStatus,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_taxi,
                    color: isOnline ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    isOnline ? "Online" : "Offline",
                    style: TextStyle(
                      color: isOnline ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: screenHeight * 0.45,
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user2.png'),
                          radius: 25,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "John Doe",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16,
                                ),
                                Text(
                                  "4.9",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.green,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 15,
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 30,
                              width: 1,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 5),
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 15,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "CMC",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "VIT",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/auto.png',
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Distance",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "1.4 km",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Time",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "6 min",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "₹150",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: screenWidth * 1.2,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
<<<<<<< HEAD
                          // Cancel booking action

                          // For now added the ride completion page.
                          Navigator.of(context)
                              .pushReplacementNamed("/ridecompletion");
=======
                          Navigator.of(context).pushReplacementNamed("/ridecompletion");
>>>>>>> 07d8e1b (Vatsal Connecting to Github)
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
<<<<<<< HEAD
                            Icon(Icons.cancel, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Cancel Your Booking",
=======
                            Text(
                              "Ride Completed",
>>>>>>> 07d8e1b (Vatsal Connecting to Github)
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
