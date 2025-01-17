import 'package:flutter/material.dart';

import 'package:howgorithm/widgets/algorithm_app_bar.dart';

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
        child: Text("Merge Sort Screen Placeholder"),
      ),
    );
  }
}
