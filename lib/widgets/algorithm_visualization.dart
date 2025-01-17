import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/number_box.dart';

Widget algorithmVisualization(dynamic step) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < step.arraySnapshot.length; i++)
              numberBox(
                value: step.arraySnapshot[i],
                isHighlighted: step.highlightIndices.contains(i),
              ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Text(
        step.description,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
