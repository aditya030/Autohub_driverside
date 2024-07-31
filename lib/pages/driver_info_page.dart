import 'package:autohub_driverside/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverDetailsPage extends StatefulWidget {
  @override
  _DriverDetailsPageState createState() => _DriverDetailsPageState();
}

class _DriverDetailsPageState extends State<DriverDetailsPage> {
  final TextEditingController nameController =
      TextEditingController(text: 'Raaj');
  final TextEditingController vehicleNumberController =
      TextEditingController(text: 'TN XX XX XXXX');
  final TextEditingController phoneNumberController =
      TextEditingController(text: '+91 XXXXX XXXXX');
  final TextEditingController languageController =
      TextEditingController(text: 'Tamil, English, Hindi');
  List<String> paymentMethods = ['UPI', 'CASH'];
  String selectedPaymentMethod = 'UPI';

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void _addPaymentMethod(String method) {
    setState(() {
      paymentMethods.add(method);
      selectedPaymentMethod = method;
    });
  }

  void _saveDriverDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('drivers').doc(user.uid).set({
        'name': nameController.text,
        'vehicleNumber': vehicleNumberController.text,
        'phoneNumber': phoneNumberController.text,
        'language': languageController.text,
        'paymentMethods': paymentMethods,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Driver details saved successfully')),
      );
      Navigator.pushReplacementNamed(
          context, '/homepage'); // Navigate to home page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user is signed in')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDriverDetails,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                    'assets/images/user2.png'), // Replace with user's profile image
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  // Handle edit profile image
                },
                child: Text(
                  'Edit profile image',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 16.0),
              UserInfoField(label: 'Name', controller: nameController),
              UserInfoField(
                  label: 'Vehicle Number', controller: vehicleNumberController),
              UserInfoField(
                  label: 'Phone Number', controller: phoneNumberController),
              ...paymentMethods.map((method) => UserInfoField(
                    label: 'Payment Methods Accepted',
                    controller: TextEditingController(text: method),
                  )),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                ),
                value: selectedPaymentMethod,
                items: ['UPI', 'Cash', 'Card']
                    .map((method) => DropdownMenuItem<String>(
                          value: method,
                          child: Text(method),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    _addPaymentMethod(value);
                  }
                },
              ),
              SizedBox(height: 8.0),
              UserInfoField(label: 'Language', controller: languageController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_outlined),
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
}

class UserInfoField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  UserInfoField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              suffixIcon: IconButton(
                icon: Icon(Icons.edit, color: Colors.grey),
                onPressed: () {
                  // Handle edit
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
