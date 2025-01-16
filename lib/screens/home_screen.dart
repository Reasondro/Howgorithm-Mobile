import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Quick summary or welcome
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to Howgorithms!\nSelect an algorithm to learn more.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          // Two buttons for now: Bubble Sort and Binary Search
        ],
      ),
    );
  }
}
