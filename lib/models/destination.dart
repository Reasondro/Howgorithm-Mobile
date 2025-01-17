import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const destinations = [
  Destination(label: "Home", icon: Icons.home),
  Destination(label: "Algorithms", icon: Icons.device_hub),
  Destination(label: "Quizzes", icon: Icons.quiz),
  Destination(label: "Profile", icon: Icons.person),
];
