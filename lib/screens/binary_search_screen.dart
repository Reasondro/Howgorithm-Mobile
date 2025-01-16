import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' show Platform;

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Platform.isIOS
              ? const Icon(
                  Icons.arrow_back_ios,
                  size: 50,
                )
              : const Icon(
                  Icons.arrow_back,
                  size: 50,
                ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: const Center(
        child: Text("Binary Search Screen Placeholder"),
      ),
    );
  }
}
