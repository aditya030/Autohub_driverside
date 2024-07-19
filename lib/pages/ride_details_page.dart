import 'package:flutter/material.dart';

class RideDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Details'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                RideCard(
                  price: '₹125',
                  avgBid: '₹135',
                  maxBid: '₹170',
                  startLocation: 'VIT Main Gate',
                  endLocation: 'Katpadi Railway Station',
                  paymentMode: 'Cash',
                  userBid: '₹150',
                ),
                // You can add more RideCards here if needed
              ],
            ),
          ),
          SlidingButton(
            onConfirm: () {
              // Handle the ride confirmation here
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Ride Confirmed'),
                  content: Text('Your ride has been confirmed.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RideCard extends StatelessWidget {
  final String price;
  final String avgBid;
  final String maxBid;
  final String startLocation;
  final String endLocation;
  final String paymentMode;
  final String userBid;

  RideCard({
    required this.price,
    required this.avgBid,
    required this.maxBid,
    required this.startLocation,
    required this.endLocation,
    required this.paymentMode,
    required this.userBid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[100],
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              price,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Avg bid: $avgBid',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Max bid: $maxBid',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 10.0),
                Text(
                  startLocation,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 10.0),
                Text(
                  endLocation,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Payment Mode: $paymentMode',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Your Bid: $userBid',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlidingButton extends StatefulWidget {
  final VoidCallback onConfirm;

  SlidingButton({required this.onConfirm});

  @override
  _SlidingButtonState createState() => _SlidingButtonState();
}

class _SlidingButtonState extends State<SlidingButton> {
  double _buttonWidth = 300.0; // Increased width
  double _dragPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        children: [
          Container(
            width: _buttonWidth,
            height: 60.0, // Increased height
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius:
                  BorderRadius.circular(35.0), // Adjusted border radius
            ),
            child: Center(
              child: Text(
                'Slide to Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0, // Increased font size
                ),
              ),
            ),
          ),
          Positioned(
            left: _dragPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition += details.delta.dx;
                  if (_dragPosition < 0) _dragPosition = 0;
                  if (_dragPosition > _buttonWidth - 70)
                    _dragPosition =
                        _buttonWidth - 70; // Adjusted position limit
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragPosition >= _buttonWidth - 70) {
                  widget.onConfirm();
                }
                setState(() {
                  _dragPosition = 0;
                });
              },
              child: Container(
                width: 60.0, // Increased width
                height: 60.0, // Increased height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(35.0), // Adjusted border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(Icons.chevron_right,
                      color: Colors.green, size: 35.0), // Increased icon size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
