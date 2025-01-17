import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howgorithm/router/routes.dart';
import 'package:howgorithm/widgets/algorithm_card.dart';

class AlgorithmsScreen extends StatelessWidget {
  const AlgorithmsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> algorithms = [
      {
        'title': 'Bubble Sort',
        'description': 'A simple comparison-based sorting algorithm.',
        'icon': Icons.bubble_chart_outlined,
        'animation': "assets/animations/bubble3.json",
        'route': Routes.nestedBubbleSortScreen,
      },
      {
        'title': 'Merge Sort',
        'description': 'EMPTY',
        'icon': Icons.merge_outlined,
        'animation': "assets/animations/merge1.json",
        'route': Routes.nestedMergeSortScreen,
      },
      {
        'title': 'Classical Search',
        'description': 'EMPTY',
        'icon': Icons.search_outlined,
        'animation': "assets/animations/classical1.json",
        'route': Routes.nestedClassicalSearchScreen,
      },
      {
        'title': 'Binary Search',
        'description': 'Quickly search for an element in a sorted array.',
        'icon': Icons.switch_left_outlined,
        'animation': "assets/animations/binary1.json",
        'route': Routes.nestedBinarySearchScreen,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore the fundamentals of each algorithm. Tap on one to learn more.',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                  mainAxisExtent: 170),
              itemCount: algorithms.length,
              itemBuilder: (BuildContext context, int index) {
                final algorithm = algorithms[index];
                return AlgorithmCard(
                  title: algorithm['title'],
                  description: algorithm['description'],
                  iconData: algorithm['icon'],
                  animation: algorithm['animation'],
                  onTap: () {
                    GoRouter.of(context).push(algorithm['route']);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
