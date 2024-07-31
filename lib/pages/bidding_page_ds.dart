import 'package:flutter/material.dart';
import 'driver_bids_page.dart'; // Import the DriverBidsPage

class BiddingPage extends StatefulWidget {
  @override
  _BiddingPageState createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  int _selectedBidIndex = -1;

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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Sort by : ₹ Prices'),
            ),
            _buildPriceCard(context, 0, '₹246', 'CMC', 'VIT', 'Cash'),
            _buildPriceCard(context, 1, '₹135', 'R Block', 'INOX Cinemas', 'Cash'),
            _buildPriceCard(context, 2, '₹200', 'VIT Main Gate', 'Vellore Kitchen', 'Cash'),
            _buildPriceCard(context, 3, '₹125', 'VIT Main Gate', 'Katpadi Railway Station', 'Cash'),
            _buildPriceCard(context, 4, '₹350', 'VIT Main Gate', 'Vellore Fort', 'Cash'),
          ],
        ),
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

  Widget _buildPriceCard(BuildContext context, int index, String price, String start, String end, String payment) {
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
              driverName: 'Driver Name', // Update this as needed
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
                price,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.green),
                  SizedBox(width: 8),
                  Text(start),
                ],
              ),
              if (end.isNotEmpty) ...[
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 8),
                    Text(end),
                  ],
                ),
              ],
              SizedBox(height: 8),
              Text('Payment Mode: $payment'),
            ],
          ),
        ),
      ),
    );
  }
}