import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:howgorithm/router/routes.dart';
import 'package:lottie/lottie.dart';
// import your custom widgets if needed
// import 'package:howgorithm/widgets/quiz_card.dart'; // Or something similar
// import 'package:howgorithm/router/routes.dart'; // Make sure routes are correct

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This data mimics your algorithm list, but specifically for quizzes
    final List<Map<String, dynamic>> quizzes = [
      {
        'title': 'Bubble Sort Quiz',
        'description': 'Test your Bubble Sort knowledge!',
        'icon': Icons.bubble_chart_outlined,
        'animation': "assets/animations/bubble3.json",
        'route': Routes.nestedBubbleSortQuizScreen
      },
      {
        'title': 'Merge Sort Quiz',
        'description': 'Challenge yourself with Merge Sort trivia!',
        'icon': Icons.merge_outlined,
        'animation': "assets/animations/merge1.json",
        'route': Routes.nestedMergeSortQuizScreen
      },
      {
        'title': 'Classical Search Quiz',
        'description': 'Check your classical search algorithms knowledge!',
        'icon': Icons.search_outlined,
        'animation': "assets/animations/classical5.json",
        'route': Routes.nestedClassicalSearchQuizScreen
      },
      {
        'title': 'Binary Search Quiz',
        'description': 'Find answers fast—just like Binary Search!',
        'icon': Icons.switch_left_outlined,
        'animation': "assets/animations/binary8.json",
        'route': Routes.nestedBinarySearchQuizScreen
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      // No Scaffold here, as you requested
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title / heading
          Text(
            'Ready for a Challenge?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            'Select a quiz below to test your knowledge!',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Carousel of quiz cards
          Expanded(
            child: CarouselSlider(
              items: quizzes.map((quiz) {
                return Builder(
                  builder: (BuildContext context) {
                    return _QuizCard(
                      title: quiz['title'],
                      description: quiz['description'],
                      animation: quiz['animation'],
                      onTap: () {
                        // Navigate to the quiz route
                        GoRouter.of(context).push(quiz['route']);
                      },
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: double.infinity, // Fill available vertical space
                enlargeCenterPage: true, // Center the "active" card
                enableInfiniteScroll: true, // Loop through items
                autoPlay: true, // Auto-scroll
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                pauseAutoPlayOnTouch: true,
                viewportFraction:
                    0.8, // Size of each card (80% of screen width)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A fancy quiz card inside the carousel
class _QuizCard extends StatelessWidget {
  final String title;
  final String description;

  final String animation;
  final VoidCallback onTap;

  const _QuizCard({
    required this.title,
    required this.description,
    required this.animation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        // Height is determined by the Carousel; you can tweak styling below
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black26,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(animation, width: 200, height: 200),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
