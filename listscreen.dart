import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'aboutscreen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  final List<Map<String, String>> destinations = const [
    {"name": "Paris", "desc": "The city of love and lights."},
    {"name": "Tokyo", "desc": "Modern city with rich culture."},
    {"name": "New York", "desc": "The city that never sleeps."},
    {"name": "Dubai", "desc": "Luxury and desert adventures."},
    {"name": "London", "desc": "Historic landmarks and royal heritage."},
    {"name": "Rome", "desc": "Home to ancient wonders."},
    {"name": "Sydney", "desc": "Famous for its Opera House."},
    {"name": "Bali", "desc": "Tropical paradise with beaches."},
    {"name": "Istanbul", "desc": "Where East meets West."},
    {"name": "Cairo", "desc": "Land of pyramids and pharaohs."},
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
        child: ListView.builder(
          itemCount: destinations.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.teal),
                title: Text(destinations[index]['name']!),
                subtitle: Text(destinations[index]['desc']!),
              ),
            );
          },
        ),
      ),
    );
  }
}