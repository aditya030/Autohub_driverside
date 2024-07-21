import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:driver/pages/add_bid_page.dart';
=======
import 'dart:async';
import 'package:autohub_driverside/pages/add_bid_page.dart';
>>>>>>> 07d8e1b (Vatsal Connecting to Github)

class DriverBidsPage extends StatefulWidget {
  @override
  _DriverBidsPageState createState() => _DriverBidsPageState();
}

class _DriverBidsPageState extends State<DriverBidsPage> {
  List<Bid> bids = [
<<<<<<< HEAD
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

=======
    Bid(driverName: 'John Doe', price: '₹246', start: 'CMC', end: 'VIT', payment: 'Cash'),
    Bid(driverName: 'Alice Smith', price: '₹135', start: 'R Block', end: 'INOX Cinemas', payment: 'Cash'),
    Bid(driverName: 'Bob Brown', price: '₹200', start: 'VIT Main Gate', end: 'Vellore Kitchen', payment: 'Cash'),
    Bid(driverName: 'Emma Lee', price: '₹125', start: 'VIT Main Gate', end: 'Katpadi Railway Station', payment: 'Cash'),
    Bid(driverName: 'Mike Wilson', price: '₹350', start: 'VIT Main Gate', end: 'Vellore Fort', payment: 'Cash'),
  ];

  Timer? _timer;
  int _start = 30;

  void _startTimer() {
    _start = 30;
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          timer.cancel();
          Navigator.pushNamedAndRemoveUntil(context, '/rideconfirmation', (route) => false);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

>>>>>>> 07d8e1b (Vatsal Connecting to Github)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Bids'),
      ),
<<<<<<< HEAD
      body: ListView.builder(
        itemCount: bids.length,
        itemBuilder: (context, index) {
          return _buildBidCard(context, index, bids[index]);
        },
=======
      body: Stack(
        children: [
          ListView.builder(
            itemCount: bids.length,
            itemBuilder: (context, index) {
              return _buildBidCard(context, index, bids[index]);
            },
          ),
          Positioned(
            top: 10,
            right: 10,
            child: _start > 0
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.black54,
                    child: Text(
                      '$_start',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : Container(),
          ),
        ],
>>>>>>> 07d8e1b (Vatsal Connecting to Github)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddBid(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddBid(BuildContext context) async {
<<<<<<< HEAD
    // Navigate to AddBidPage and wait for a result
    final newBid = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddBidPage()));
=======
    final newBid = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBidPage()),
    );
>>>>>>> 07d8e1b (Vatsal Connecting to Github)

    if (newBid != null && newBid is Bid) {
      setState(() {
        bids.add(newBid);
      });
<<<<<<< HEAD
=======

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bid added successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );

      _startTimer();
>>>>>>> 07d8e1b (Vatsal Connecting to Github)
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
<<<<<<< HEAD
=======

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
>>>>>>> 07d8e1b (Vatsal Connecting to Github)
