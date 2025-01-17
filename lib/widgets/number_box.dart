import 'package:flutter/material.dart';
import 'package:howgorithm/main.dart';

Widget numberBox({required double value, required bool isHighlighted}) {
  final boxColor = isHighlighted
      ? howgorithmColorTheme.inversePrimary
      : howgorithmColorTheme.inverseSurface;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: boxColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      value.toString(),
      style: TextStyle(
          color: isHighlighted
              ? howgorithmColorTheme.onSurface
              : howgorithmColorTheme.onInverseSurface,
          fontSize: 16,
          fontWeight: FontWeight.w600),
    ),
  );
}
