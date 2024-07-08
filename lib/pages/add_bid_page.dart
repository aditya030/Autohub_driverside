import 'package:flutter/material.dart';

class AddBidPage extends StatelessWidget {
  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController bidAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bid'),
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
    final String driverName = driverNameController.text.trim();
    final String bidAmount = bidAmountController.text.trim();

    if (driverName.isNotEmpty && bidAmount.isNotEmpty) {
      // Create a new Bid object
      Navigator.pop(
        context,
        Bid(
          driverName: driverName,
          price: '₹$bidAmount', // Assuming you format the amount as needed
          start: '', // You may add default values or handle differently
          end: '',
          payment: 'Cash', // Example, adjust as per your needs
        ),
      );
    } else {
      // Show error or handle validation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Validation Error'),
          content: Text('Please enter both Driver Name and Bid Amount.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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
