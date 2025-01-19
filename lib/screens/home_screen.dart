import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class _FunFactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FunFactRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Lottie.asset(
            'assets/animations/home.json',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: const Color.fromARGB(69, 0, 0, 0),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      // RotateAnimatedText(
                      //   'HOWGORITHM',
                      //   textStyle: Theme.of(context)
                      //       .textTheme
                      //       .titleLarge!
                      //       .copyWith(
                      //         color:
                      //             Theme.of(context).colorScheme.inversePrimary,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      // ),
                      RotateAnimatedText(
                        'Explore & Learn',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      RotateAnimatedText(
                        'Master Algorithms',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      RotateAnimatedText(
                        'Accelerate problem-solving',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      RotateAnimatedText(
                        'Level up your logic',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      RotateAnimatedText(
                        'Unlock deeper insights',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      RotateAnimatedText(
                        'Advance algorithmic thinking',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Immerse yourself in step-by-step visualizations\n'
                  'and interactive quizzes to build a robust\n'
                  'foundation in algorithmic thinking.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    children: [
                      _FunFactRow(
                        icon: Icons.sort,
                        text: 'Learn Sorting Techniques (Bubble, Merge, etc.)',
                      ),
                      SizedBox(height: 8),
                      _FunFactRow(
                        icon: Icons.search_outlined,
                        text: 'Explore Searching Methods (Binary, BFS, etc.)',
                      ),
                      SizedBox(height: 8),
                      _FunFactRow(
                        icon: Icons.quiz_outlined,
                        text: 'Test your skills with engaging quizzes',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
