import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howgorithm/router/routes.dart';

class AlgorithmsScreen extends StatelessWidget {
  const AlgorithmsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // A list of algorithms to be displayed as cards
    final List<Map<String, dynamic>> algorithms = [
      {
        'title': 'Bubble Sort',
        'description': 'A simple comparison-based sorting algorithm.',
        'icon': Icons.bubble_chart_outlined,
        'route': Routes.nestedBubbleSortScreen,
      },
      {
        'title': 'Merge Sort',
        'description': 'EMPTY',
        'icon': Icons.merge_outlined,
        'route': Routes.nestedMergeSortScreen,
      },
      {
        'title': 'Classical Search',
        'description': 'EMPTY',
        'icon': Icons.search_outlined,
        'route': Routes.nestedClassicalSearchScreen,
      },
      {
        'title': 'Binary Search',
        'description': 'Quickly search for an element in a sorted array.',
        'icon': Icons.sync_alt_outlined,
        'route': Routes.nestedBinarySearchScreen,
      },
      // Add more algorithms here if needed
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtitle / instructions
          Text(
            'Explore the fundamentals of each algorithm. Tap on one to learn more.',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Expanded GridView for algorithm cards
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of cards per row
                crossAxisSpacing: 16.0, // Horizontal spacing
                mainAxisSpacing: 16.0, // Vertical spacing
                childAspectRatio: 0.8, // Adjust height/width ratio
              ),
              itemCount: algorithms.length,
              itemBuilder: (BuildContext context, int index) {
                final algorithm = algorithms[index];
                return _AlgorithmCard(
                  title: algorithm['title'],
                  description: algorithm['description'],
                  iconData: algorithm['icon'],
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

// A reusable widget for each algorithm card
class _AlgorithmCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final VoidCallback onTap;

  const _AlgorithmCard({
    required this.title,
    required this.description,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Trigger navigation when the card is tapped
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon or image at the top
              Icon(
                iconData,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                textAlign: TextAlign.center,
              ),
              // Description
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
