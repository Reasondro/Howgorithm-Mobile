// TODO impelmenet algorithm control

// import 'package:flutter/material.dart';

// class AlgorithmControl extends StatefulWidget {
//   const AlgorithmControl(
//       {super.key, required this.hasSteps, required this.currentStep});

//   final bool hasSteps;
//   final int currentStep;

//   @override
//   State<AlgorithmControl> createState() => _AlgorithmControlState();
// }

// class _AlgorithmControlState extends State<AlgorithmControl> {
//   final int tempCurrentStep = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Previous button
//         ElevatedButton.icon(
//             onPressed: widget.hasSteps && widget.currentStep > 0
//                 ? () {
//                     setState(() {
//                       currentStep--;
//                     });
//                   }
//                 : null,
//             label: const Icon(Icons.skip_previous_outlined, size: 40)),
//         //? step indicator
//         if (widget.hasSteps)
//           Text(
//             'Step ${widget.currentStep} of ${steps.length - 1}',
//             style: const TextStyle(fontSize: 16),
//           )
//         else
//           const Text('-', style: TextStyle(fontSize: 16, color: Colors.white)),
//         // Next button
//         ElevatedButton.icon(
//           onPressed: widget.hasSteps && widget.currentStep < steps.length - 1
//               ? () {
//                   setState(() {
//                     currentStep++;
//                   });
//                 }
//               : null,
//           label: const Icon(Icons.skip_next_outlined, size: 40), // empty label
//         ),
//       ],
//     );
//   }
// }
