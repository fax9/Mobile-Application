import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'listscreen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final List<Map<String, String>> landmarks = const [
    {"name": "Eiffel Tower", "image": "assets/eifal tower.jpeg"},
    {"name": "Great Wall", "image": "assets/great wall of china.jpeg"},
    {"name": "Taj Mahal", "image": "assets/taj mahal.jpeg"},
    {"name": "Pyramids", "image": "assets/payramids.jpeg"},
    {"name": "Colosseum", "image": "assets/colossem.jpeg"},
    {"name": "Statue of Liberty", "image": "assets/statue of liberty.jpeg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Travel Guide")),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home Screen"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("List Screen"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About Screen"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: landmarks.map((place) {
            return Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      place['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      place['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
