import 'package:flutter/material.dart';

import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'dart:io' show Platform;

class MergeSortQuizScreen extends StatefulWidget {
  const MergeSortQuizScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MergeSortQuizScreenState();
  }
}

class _MergeSortQuizScreenState extends State<MergeSortQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AlgorithmAppBar(),
      body: Center(
        child: Text(
          "Merge Sort\nCOMING IN SUMMER 2025 ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
