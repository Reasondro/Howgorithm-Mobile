import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AlgorithmCard extends StatelessWidget {
  const AlgorithmCard({
    super.key,
    required this.title,
    required this.description,
    // required this.iconData,
    required this.animation,
    required this.onTap,
  });

  final String title;
  final String description;
  // final IconData iconData;
  final String animation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Icon(
                  //   iconData,
                  //   size: 48,
                  //   color: Theme.of(context).colorScheme.primary,
                  // ),
                  Lottie.asset(animation, width: 64, height: 64),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
