import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'package:howgorithm/widgets/algorithm_card.dart';

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
      appBar: const AlgorithmAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Hero(
                  tag: "Bubble Sort",
                  child: AlgorithmCard(
                      title: "Bubble Sort",
                      description:
                          "A simple comparison-based sorting algorithm.",
                      iconData: Icons.bubble_chart_outlined,
                      onTap: () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
