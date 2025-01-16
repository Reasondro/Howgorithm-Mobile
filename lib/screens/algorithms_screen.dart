import 'package:flutter/material.dart';

class AlgorithmsScreen extends StatefulWidget {
  const AlgorithmsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AlgorithmsScreenState();
  }
}

class _AlgorithmsScreenState extends State<AlgorithmsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text("Algorithms"),
        ));
  }
}
