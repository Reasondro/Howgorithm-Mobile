import 'package:flutter/material.dart';
import 'lab_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Quick summary or welcome
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to Howgorithms!\nSelect an algorithm to learn more.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          // Two buttons for now: Bubble Sort and Binary Search
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LabScreen(algorithm: 'bubble'),
                ),
              );
            },
            child: const Text('Bubble Sort'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LabScreen(algorithm: 'binary'),
                ),
              );
            },
            child: const Text('Binary Search'),
          ),
        ],
      ),
    );
  }
}
