import 'package:flutter/material.dart';

import 'package:howgorithm/widgets/algorithm_app_bar.dart';

class BinarySearchScreen extends StatefulWidget {
  const BinarySearchScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return BinarySearchScreenState();
  }
}

class BinarySearchScreenState extends State<BinarySearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AlgorithmAppBar(),
      body: Center(
        child: Text("Binary Search Screen Placeholder"),
      ),
    );
  }
}
