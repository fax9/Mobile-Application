import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProfileApp',
      debugShowCheckedModeBanner: false,
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String _validationMessage = '';

  @override
  Widget build(BuildContext context) {
    // Detect screen orientation
    var orientation = MediaQuery.of(context).orientation == Orientation.portrait
        ? "Portrait"
        : "Landscape";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.purpleAccent,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // RichText for name and email
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Hamza Hashmi\n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      TextSpan(
                        text: "hashmihamza894@gmail.com",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Row of Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Followed!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text("Follow"),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Message Sent!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text("Message"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Container with short description
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "I am a Flutter developer passionate about creating clean, "
                        "functional, and beautiful mobile apps.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),

                // TextField for username editing
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Edit Username",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        setState(() {
                          if (_usernameController.text.isEmpty) {
                            _validationMessage =
                            "Username cannot be empty!";
                          } else {
                            _validationMessage =
                            "Username updated successfully!";
                          }
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _validationMessage,
                  style: TextStyle(
                    color: _validationMessage.contains("success")
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                const SizedBox(height: 30),

                // Display Orientation
                Text(
                  "Current Orientation: $orientation",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
