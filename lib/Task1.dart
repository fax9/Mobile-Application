import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MaximumBid(),
    debugShowCheckedModeBanner: false,
  ));
}

class MaximumBid extends StatefulWidget {
  const MaximumBid({super.key});

  @override
  _MaximumBidState createState() => _MaximumBidState();
}

class _MaximumBidState extends State<MaximumBid> {
  int _currentBid = 100; // Starting bid

  void _increaseBid() {
    setState(() {
      _currentBid += 50; // Increments by $50
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bidding Page"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Current Maximum Bid:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Text(
              "\$$_currentBid",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _increaseBid,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text("Increase Bid"),
            ),
          ],
        ),
      ),
    );
  }
}
