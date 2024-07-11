import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DriverEarningsPage(),
    );
  }
}

class DriverEarningsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_back, color: Colors.black),
                                Spacer(),
                                Text('9:41', style: TextStyle(color: Colors.black)),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.signal_cellular_alt, color: Colors.black),
                                    SizedBox(width: 4),
                                    Icon(Icons.wifi, color: Colors.black),
                                    SizedBox(width: 4),
                                    Icon(Icons.battery_full, color: Colors.black),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage('https://example.com/avatar.jpg'), // Replace with actual image URL or asset image
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Rakesh Gupta', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 16),
                                        SizedBox(width: 4),
                                        Text('4.9', style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Text('Earned Today', style: TextStyle(fontSize: 16)),
                                  Text('₹750', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Total Trips', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                          Text('15', style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text('Time Online', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                          Text('8h 40m', style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text('Total Km', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                          Text('55 Km', style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Trip', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage('https://example.com/johndoe.jpg'), // Replace with actual image URL or asset image
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('John Doe', style: TextStyle(fontSize: 16)),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 16),
                                        SizedBox(width: 4),
                                        Text('4.9', style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.message, color: Colors.green, size: 30),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChatSection()),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.circle, color: Colors.green, size: 16),
                                    Container(
                                      height: 40,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    Icon(Icons.location_pin, color: Colors.red, size: 16),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('CMC', style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 30),
                                    Text('VIT', style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Clear part of the doodle image at the bottom
              Container(
                height: 200.0, // Adjust the height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/full_background_doodle.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter, // Align bottom part of the image
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatSection extends StatefulWidget {
  @override
  _ChatSectionState createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  final List<Map<String, String>> _messages = [
    {'sender': 'John Doe', 'message': 'Hi, are you on the way?'},
    {'sender': 'You', 'message': 'Yes, I will be there in 5 minutes.'},
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'You', 'message': _controller.text});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with John Doe'),
        backgroundColor: Colors.green[200],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message['sender']!),
                  subtitle: Text(message['message']!),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
