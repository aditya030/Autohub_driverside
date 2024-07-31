import 'dart:async';
import 'package:flutter/material.dart';
import 'add_bid_page.dart';
import 'ride_confirmation_page.dart'; // Import the page

class DriverBidsPage extends StatefulWidget {
  final String driverName;
  final String destination;

  DriverBidsPage({required this.driverName, required this.destination});

  @override
  _DriverBidsPageState createState() => _DriverBidsPageState();
}

class _DriverBidsPageState extends State<DriverBidsPage> {
  List<Bid> allBids = []; // List of all bids
  Bid? _currentBid; // Variable to track the driver's current bid

  List<Bid> get filteredBids {
    print("Filtering bids for destination: ${widget.destination}");
    final bids = allBids.where((bid) => bid.end == widget.destination).toList();
    print("Filtered Bids: $bids");
    return bids;
  }

  late Timer _timer;
  Duration _remainingTime = Duration(seconds: 30);
  bool _showCountdown = false;
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    // Debugging: Print initial state
    print("Destination: ${widget.destination}");
    print("All Bids: ${allBids}");
  }

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
          if (filteredBids.isEmpty)
            Center(
              child: Text(
                'No bids available. Please add a bid.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          else
            ListView.builder(
              itemCount: filteredBids.length,
              itemBuilder: (context, index) {
                return _buildBidCard(context, index, filteredBids[index]);
              },
            ),
          if (_showCountdown)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Redirect in ${_remainingTime.inSeconds}s',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          if (_showPopup)
            Positioned(
              bottom: 0,
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
        child: Icon(_currentBid == null ? Icons.add : Icons.edit),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _navigateToAddBid(BuildContext context) async {
    final editedBid = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBidPage(
          driverName: widget.driverName,
          initialBid: _currentBid,
        ),
      ),
    );

    if (editedBid != null && editedBid is Bid) {
      setState(() {
        if (_currentBid == null) {
          allBids.add(editedBid); // Add new bid if no current bid
        } else {
          final index = allBids.indexWhere((bid) =>
              bid.driverName == _currentBid!.driverName &&
              bid.end == _currentBid!.end);
          if (index != -1) {
            allBids[index] = editedBid; // Update existing bid
          }
        }
        _currentBid = editedBid;

        // Debugging: Print updated state
        print("Added/Updated Bid: $editedBid");
        print("All Bids: $allBids");

        // Ensure bids are sorted in ascending order based on price
        allBids.sort((a, b) => int.parse(a.price.replaceAll('₹', ''))
            .compareTo(int.parse(b.price.replaceAll('₹', ''))));

        _showPopup = true;
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _showPopup = false;
          });
        });
      });

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

  @override
  String toString() {
    return 'Bid(driverName: $driverName, price: $price, start: $start, end: $end, payment: $payment)';
  }
}