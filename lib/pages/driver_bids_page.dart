import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:autohub_driverside/pages/add_bid_page.dart';
import 'package:autohub_driverside/pages/ride_confirmation_page.dart'; // Import the page

class DriverBidsPage extends StatefulWidget {
  @override
  _DriverBidsPageState createState() => _DriverBidsPageState();
}

class _DriverBidsPageState extends State<DriverBidsPage> {
  List<Bid> bids = [
    Bid(
        driverName: 'John Doe',
        price: '₹246',
        start: 'CMC',
        end: 'VIT',
        payment: 'Cash'),
    Bid(
        driverName: 'Alice Smith',
        price: '₹135',
        start: 'R Block',
        end: 'INOX Cinemas',
        payment: 'Cash'),
    Bid(
        driverName: 'Bob Brown',
        price: '₹200',
        start: 'VIT Main Gate',
        end: 'Vellore Kitchen',
        payment: 'Cash'),
    Bid(
        driverName: 'Emma Lee',
        price: '₹125',
        start: 'VIT Main Gate',
        end: 'Katpadi Railway Station',
        payment: 'Cash'),
    Bid(
        driverName: 'Mike Wilson',
        price: '₹350',
        start: 'VIT Main Gate',
        end: 'Vellore Fort',
        payment: 'Cash'),
  ];

  late Timer _timer;
  Duration _remainingTime = Duration(seconds: 30);
  bool _showCountdown = false;
  bool _showPopup = false;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Bids'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: bids.length,
            itemBuilder: (context, index) {
              return _buildBidCard(context, index, bids[index]);
            },
          ),
          if (_showCountdown)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black, // Set the background color to black
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Redirect in ${_remainingTime.inSeconds}s',
                  style: TextStyle(color: Colors.white), // Set the text color to white
                ),
              ),
            ),
          if (_showPopup)
            Positioned(
              bottom: 0, // Position the popup at the bottom
              left: 0,
              right: 0,
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'Bid added successfully!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddBid(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black, // Set the button color to black
        foregroundColor: Colors.white, // Set the icon color to white
      ),
    );
  }

  void _navigateToAddBid(BuildContext context) async {
    // Navigate to AddBidPage and wait for a result
    final newBid = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddBidPage()));

    if (newBid != null && newBid is Bid) {
      setState(() {
        // Insert the new bid at the top of the list
        bids.insert(0, newBid);

        // Show the success popup
        _showPopup = true;
        // Hide the popup after 3 seconds
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _showPopup = false;
          });
        });
      });

      // Start the countdown timer
      setState(() {
        _showCountdown = true;
        _remainingTime = Duration(seconds: 30);
      });

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingTime.inSeconds <= 0) {
          timer.cancel();
          setState(() {
            _showCountdown = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RideConfirmationPage()),
          );
        } else {
          setState(() {
            _remainingTime = _remainingTime - Duration(seconds: 1);
          });
        }
      });
    }
  }

  Widget _buildBidCard(BuildContext context, int index, Bid bid) {
    return GestureDetector(
      onTap: () {
        // Handle tap on bid card if needed
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Driver: ${bid.driverName}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Price: ${bid.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.green),
                  SizedBox(width: 8),
                  Text(bid.start),
                ],
              ),
              if (bid.end.isNotEmpty) ...[
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 8),
                    Text(bid.end),
                  ],
                ),
              ],
              SizedBox(height: 8),
              Text('Payment Mode: ${bid.payment}'),
            ],
          ),
        ),
      ),
    );
  }
}

class Bid {
  final String driverName;
  final String price;
  final String start;
  final String end;
  final String payment;

  Bid({
    required this.driverName,
    required this.price,
    required this.start,
    required this.end,
    required this.payment,
  });
}
