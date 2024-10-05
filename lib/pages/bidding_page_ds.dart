import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';  // Add geocoding for reverse geocoding
import 'driver_bids_page.dart'; // Import the DriverBidsPage

class BiddingPage extends StatefulWidget {
  @override
  _BiddingPageState createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  int _selectedBidIndex = -1;
  Map<int, String> _locationCache = {};  // Cache for place names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/images/auto.png',
              height: 30, // Adjust the height to fit your needs
            ),
            SizedBox(width: 10),
            Text("Bidding Page", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rides').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching ride data'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No rides available'));
          }

          final rideDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: rideDocs.length,
            itemBuilder: (context, index) {
              final rideData = rideDocs[index].data() as Map<String, dynamic>;

              // Safely extract the data, handling GeoPoint
              GeoPoint? sourceGeoPoint = rideData['source'] as GeoPoint?;
              GeoPoint? destinationGeoPoint = rideData['destination'] as GeoPoint?;
              String distance = rideData['distance'] ?? 'N/A';
              String duration = rideData['duration'] ?? 'N/A';

              // Fetch the place name for source and destination
              String source = _locationCache.containsKey(index)
                  ? _locationCache[index]!
                  : 'Loading...';
              String destination = _locationCache.containsKey(index + 1000)
                  ? _locationCache[index + 1000]!
                  : 'Loading...';

              // Fetch the location name asynchronously and update the cache
              if (!_locationCache.containsKey(index) && sourceGeoPoint != null) {
                _fetchPlaceName(sourceGeoPoint, index, isSource: true);
              }
              if (!_locationCache.containsKey(index + 1000) && destinationGeoPoint != null) {
                _fetchPlaceName(destinationGeoPoint, index + 1000, isSource: false);
              }

              return _buildPriceCard(
                  context, index, distance, duration, source, destination);
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
        ],
      ),
    );
  }

  // Function to reverse geocode GeoPoint to place name
  Future<void> _fetchPlaceName(GeoPoint geoPoint, int index, {required bool isSource}) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        geoPoint.latitude,
        geoPoint.longitude,
      );

      if (placemarks.isNotEmpty) {
        String placeName = '${placemarks[0].locality}, ${placemarks[0].country}';
        setState(() {
          _locationCache[index] = placeName;
        });
      } else {
        setState(() {
          _locationCache[index] = isSource ? 'Unknown Source' : 'Unknown Destination';
        });
      }
    } catch (e) {
      setState(() {
        _locationCache[index] = 'Error fetching location';
      });
    }
  }

  Widget _buildPriceCard(BuildContext context, int index, String distance, String duration, String start, String end) {
    bool highlight = _selectedBidIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBidIndex = index;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DriverBidsPage(
              driverName: 'Driver Name', // You can update this with actual data
              destination: end,
            ),
          ),
        );
      },
      child: Card(
        color: highlight ? Colors.green[100] : null,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Distance: $distance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Duration: $duration',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Source: $start'),
                ],
              ),
              if (end.isNotEmpty) ...[
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Destination: $end'),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

//UPDATE COORDINATES TO PLACE