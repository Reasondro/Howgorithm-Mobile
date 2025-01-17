import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';

class ClassicalSearchScreen extends StatefulWidget {
  const ClassicalSearchScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return ClassicalSearchScreenState();
  }
}

class ClassicalSearchScreenState extends State<ClassicalSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AlgorithmAppBar(),
      body: Center(
        child: Text(
          "Classical Search\nCOMING IN SUMMER 2025 ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
