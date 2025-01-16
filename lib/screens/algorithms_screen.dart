import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howgorithm/router/routes.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          context.go(Routes.nestedBubbleSortScreen);
        },
        child: const Text("Bubble Sort"),
      ),
    );
  }
}
