import 'package:flutter/material.dart';

class LabScreen extends StatefulWidget {
  final String algorithm;

  const LabScreen({super.key, required this.algorithm});

  @override
  State<StatefulWidget> createState() {
    return _LabScreenState();
  }
}

class _LabScreenState extends State<LabScreen> {
  // Example data to visualize the algorithm
  final List<int> arrayData = [5, 2, 9, 1, 5, 6];

  // Indexes or other stateful details if needed
  int currentStep = 0;

  // For step-by-step, you’ll handle states differently based on the algorithm
  void nextStep() {
    setState(() {
      // Placeholder logic:
      //  - If Bubble Sort, do the next swap, etc.
      //  - If Binary Search, do the next comparison, etc.
      currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Decide what to show based on the algorithm
    Widget content;
    if (widget.algorithm == 'bubble') {
      content = bubbleSortWidget();
    } else if (widget.algorithm == 'binary') {
      content = binarySearchWidget();
    } else {
      content = const Text('Unknown Algorithm');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show whichever algorithm widget was chosen
              // Expanded(child: content),
              // // Next step button
              content,
              ElevatedButton(
                onPressed: nextStep,
                child: const Text('Next Step'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bubbleSortWidget() {
    // Render your array visually and show how bubble sort is working at "currentStep"
    return Column(
      children: [
        const Text(
          'Bubble Sort Steps',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // A very simplistic representation of the array
        Text('Array: ${arrayData.join(', ')}'),
        // Display current step, explanation, etc.
        Text('Current Step: $currentStep'),
        // TODO: Add your step logic and visuals
      ],
    );
  }

  Widget binarySearchWidget() {
    // Render your array visually and show how binary search is working at "currentStep"
    return Column(
      children: [
        const Text(
          'Binary Search Steps',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // A very simplistic representation of the array
        Text('Array: ${arrayData.join(', ')}'),
        Text('Current Step: $currentStep'),
        // TODO: Add your step logic and visuals
      ],
    );
  }
}
