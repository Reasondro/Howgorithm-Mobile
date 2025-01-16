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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: AlgorithmCard(
                    title: "Bubble Sort",
                    description:
                        "A simple comparison-based sorting algorithm.\n Bubble Sort repeatedly traverses the list and swaps adjacent elements if they’re out of order. On each pass, the largest element “bubbles up” to the end of the list, and after enough passes, the entire list is sorted. It’s easy to implement but generally has poor performance (O(n²) average time).",
                    iconData: Icons.bubble_chart_outlined,
                    onTap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
