import 'package:flutter/material.dart';
import 'package:autohub_driverside/pages/driver_bids_page.dart'; // Ensure Bid class is imported

class AddBidPage extends StatelessWidget {
  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController bidAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white, // Set app bar background color to white
        iconTheme: IconThemeData(color: Colors.black), // Set icon color to black
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/full_background_doodle.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: driverNameController,
                    decoration: InputDecoration(
                      labelText: 'Driver Name',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: bidAmountController,
                    decoration: InputDecoration(
                      labelText: 'Bid Amount',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: SizedBox(
                      width: 200.0, // Adjust the width as needed
                      height: 50.0, // Adjust the height as needed
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate and add the bid
                          _addBid(context);
                        },
                        child: const Text('Add Bid'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black, // Background color
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
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

  void _addBid(BuildContext context) {
    if (driverNameController.text.isNotEmpty &&
        bidAmountController.text.isNotEmpty) {
      final newBid = Bid(
        driverName: driverNameController.text,
        price: '₹${bidAmountController.text}', // Format price with ₹ symbol
        start: 'CMC', // Example value, replace with actual value
        end: 'VIT', // Example value, replace with actual value
        payment: 'Cash', // Example value, replace with actual value
      );
      Navigator.pop(context, newBid);
    } else {
      // Show error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
