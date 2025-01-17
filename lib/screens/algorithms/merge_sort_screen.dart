import 'package:flutter/material.dart';

import 'package:howgorithm/widgets/algorithm_app_bar.dart';

class MergeSortScreen extends StatefulWidget {
  const MergeSortScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MergeSortScreenState();
  }
}

class _MergeSortScreenState extends State<MergeSortScreen> {
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
