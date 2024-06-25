import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool showChat = true; // Initially set to true to show chat messages
  final TextEditingController _message = TextEditingController(); // Controller for the message text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black), // Back button icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black), // Call button icon
            onPressed: () {
              // Handle call button press
            },
          ),
        ],
        title: Center(
          child: Text(
            'Dell Inspiran', // Title text
            style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'dell Inspiron', // Product name
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '₹ 75.00', // Product price
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white, // White box for chat messages
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: const [
                        ChatBubble(
                          message: 'Hi', // Sample chat message
                          time: '10:00 AM', // Sample time
                          isIncoming: true, // Indicates whether the message is incoming or outgoing
                        ),
                        ChatBubble(
                          message: 'Hello', // Sample chat message
                          time: '10:05 AM', // Sample time
                          isIncoming: false, // Indicates whether the message is incoming or outgoing
                        ),
                        ChatBubble(
                          message: 'How are you?', // Sample chat message
                          time: '10:10 AM', // Sample time
                          isIncoming: true, // Indicates whether the message is incoming or outgoing
                        ),
                        // Add more chat bubbles here
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showChat = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: showChat ? const Color.fromRGBO(232, 80, 91, 1) : Colors.transparent,
                                  width: 5,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Chat',
                                style: TextStyle(
                                  color: showChat ? const Color.fromRGBO(232, 80, 91, 1) : Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showChat = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: !showChat ?const  Color.fromRGBO(232, 80, 91, 1) : Colors.transparent,
                                  width: 5,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Make Offer',
                                style: TextStyle(
                                  color: !showChat ? const Color.fromRGBO(232, 80, 91, 1) : Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                showChat
                    ? const Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCard(text: 'Hi'), // Sample text card
                              TextCard(text: 'Hello'), // Sample text card
                              TextCard(text: 'Interested'), // Sample text card
                              TextCard(text: 'How are you ?'), // Sample text card
                            ],
                          ),
                        ),
                      ),
                      // Add more rows of TextCard widgets here if needed
                    ],
                  ),
                )
                    : Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OfferCard(
                                price: '75000', // Sample offer price
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Center(
                                          child:  Text(
                                            'Your Offer :',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        content: Container(
                                          height: 150, // Set the height as per your requirement
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Price: 75000', // Sample offer price
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 8),
                                              const  Text(
                                                'Waiting for seller response',
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                              const SizedBox(height: 16),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(232, 80, 91, 1)),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Edit Offer',
                                                    style: TextStyle(color: Color.fromRGBO(232, 80, 91, 1)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const OfferCard(price: '50000'), // Sample offer card
                              const OfferCard(price: '30000'), // Sample offer card
                              const OfferCard(price: '62000'), // Sample offer card
                            ],
                          ),
                        ),
                      ),
                      // Add more rows of TextCard widgets here if needed
                    ],
                  ),
                ), // Render nothing when showChat is false
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)), // Border for the top of the message input area
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file), // Attachment icon
                  onPressed: () {
                    // Handle file attachment
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _message,
                    decoration: const InputDecoration(
                      hintText: 'Type a message', // Placeholder text
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send), // Send icon
                  onPressed: () {
                    _message.clear(); // Clear message text field
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isIncoming;

  const ChatBubble({
    required this.message,
    required this.time,
    required this.isIncoming,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isIncoming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: isIncoming ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isIncoming ? Colors.grey[200] : const Color.fromRGBO(232, 80, 91, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isIncoming ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          if (!isIncoming)
            const Icon(
              Icons.done,
              color: Color.fromRGBO(232, 80, 91, 1),
              size: 14,
            ),
        ],
      ),
    );
  }
}


class TextCard extends StatelessWidget {
  final String text;

  const TextCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final String price;
  final VoidCallback? onTap;

  const OfferCard({required this.price, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
