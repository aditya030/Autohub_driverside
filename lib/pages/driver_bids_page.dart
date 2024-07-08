import 'package:flutter/material.dart';
import 'package:driver/pages/add_bid_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Bids'),
      ),
      body: ListView.builder(
        itemCount: bids.length,
        itemBuilder: (context, index) {
          return _buildBidCard(context, index, bids[index]);
        },
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
    // Navigate to AddBidPage and wait for a result
    final newBid = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddBidPage()));

    if (newBid != null && newBid is Bid) {
      setState(() {
        bids.add(newBid);
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
