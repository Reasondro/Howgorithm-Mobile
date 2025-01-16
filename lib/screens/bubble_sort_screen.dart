import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' show Platform;

class BubbleSortScreen extends StatefulWidget {
  const BubbleSortScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _BubbleSortScreenState();
  }
}

class _BubbleSortScreenState extends State<BubbleSortScreen> {
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
        child: Text("Bubble Sort Screen Placeholder"),
      ),
    );
  }
}
