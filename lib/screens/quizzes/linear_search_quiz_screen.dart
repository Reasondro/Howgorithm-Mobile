import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';

class LinearSearchQuizScreen extends StatefulWidget {
  const LinearSearchQuizScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return LinearSearchQuizScreenState();
  }
}

class LinearSearchQuizScreenState extends State<LinearSearchQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AlgorithmAppBar(),
      body: Center(
        child: Text(
          "Linear Search\nCOMING IN SUMMER 2025 ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
