import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'package:howgorithm/widgets/algorithm_card.dart';
import 'package:howgorithm/extensions/snackbar_extension.dart';
import 'package:howgorithm/widgets/algorithm_visualization.dart';

// ?? model buat nge store tiap snapshot binary search step nya + description
class _BinarySearchStep {
  final List<double> arraySnapshot;
  final String description;

  final List<int> highlightIndices;

  _BinarySearchStep(
    this.arraySnapshot,
    this.description, {
    this.highlightIndices = const [],
  });
}

class BinarySearchScreen extends StatefulWidget {
  const BinarySearchScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return BinarySearchScreenState();
  }
}

class BinarySearchScreenState extends State<BinarySearchScreen> {
  final TextEditingController _arrayController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  List<_BinarySearchStep> _steps = [];
  int _currentStep = 0;

  bool get _hasSteps => _steps.isNotEmpty;

  // TODO modularize this
  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
            onPressed: _hasSteps && _currentStep > 0
                ? () {
                    setState(() {
                      _currentStep--;
                    });
                  }
                : null,
            label: const Icon(Icons.skip_previous_outlined, size: 40)),
        //? step indicator
        if (_hasSteps)
          Text(
            'Step $_currentStep of ${_steps.length - 1}',
            style: const TextStyle(fontSize: 16),
          )
        else
          const Text('-', style: TextStyle(fontSize: 16, color: Colors.white)),
        ElevatedButton.icon(
          onPressed: _hasSteps && _currentStep < _steps.length - 1
              ? () {
                  setState(() {
                    _currentStep++;
                  });
                }
              : null,
          label: const Icon(Icons.skip_next_outlined, size: 40), //? empty
        ),
      ],
    );
  }

  //? parse inputs, then run step-by-step binary  search nya
  void _computeSteps() {
    final rawArray = _arrayController.text.trim();
    final rawTarget = _targetController.text.trim();

    if (rawArray.isEmpty || rawTarget.isEmpty) {
      context.customShowErrorSnackBar('Please enter both array and target!');
      return;
    }

    //? parse arr
    final parts = rawArray.split(',');
    final doubleList = <double>[];
    for (var p in parts) {
      final val = double.tryParse(p.trim());
      if (val != null) {
        doubleList.add(val);
      } else {
        context.customShowErrorSnackBar('Please enter a valid array!');
        return;
      }
    }
    // ? sort for dumb users
    doubleList.sort();

    //? parase target
    final targetVal = double.tryParse(rawTarget);
    if (targetVal == null) {
      context.customShowErrorSnackBar('Please enter a valid target!');
      return;
    }

    _steps = _binarySearchWithSnapshots(doubleList, targetVal);
    _currentStep = 0;
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  //? return list of steps buat si binary search
  List<_BinarySearchStep> _binarySearchWithSnapshots(
      List<double> inputArray, double target) {
    final steps = <_BinarySearchStep>[];

    //? again buat copy
    final arr = List<double>.from(inputArray);

    int low = 0;
    int high = arr.length - 1;

    //? initialiation step
    steps.add(_BinarySearchStep(
      List<double>.from(arr),
      'Initial:\nlow=0, mid=${(0 + (arr.length - 1 - 0) ~/ 2)}, high=${arr.length - 1}',
      highlightIndices: [],
    ));

    while (low <= high) {
      final mid = (low + high) ~/ 2;

      //? step => highlighting mid
      steps.add(_BinarySearchStep(
        List<double>.from(arr),
        'Checking mid index [$mid]:\n${arr[mid]}',
        highlightIndices: [mid],
      ));

      if (arr[mid] == target) {
        steps.add(_BinarySearchStep(
          List<double>.from(arr),
          'Found $target at index [$mid]',
          highlightIndices: [mid],
        ));
        return steps; //? bisa stop here
      } else if (arr[mid] < target) {
        // ?search right
        steps.add(_BinarySearchStep(
          List<double>.from(arr),
          '${arr[mid]} < $target, so search right:\nlow=${mid + 1}, mid=${mid + 1 + (high - (mid + 1)) ~/ 2}, high=$high',
          highlightIndices: [mid],
        ));
        low = mid + 1;
      } else {
        //? search left
        steps.add(_BinarySearchStep(
          List<double>.from(arr),
          '${arr[mid]} > $target, so search left:\nlow=$low, mid=${low + ((mid - 1) - low) ~/ 2} , high=${mid - 1}',
          highlightIndices: [mid],
        ));
        high = mid - 1;
      }
    }

    //? if  exit  while loop, targetnot found
    steps.add(_BinarySearchStep(
      List<double>.from(arr),
      '$target not found in the array!',
      highlightIndices: [],
    ));

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AlgorithmAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: AlgorithmCard(
                  title: "Binary Search",
                  description:
                      "Binary Search halves the search space each time.\n"
                      "It requires a sorted array and compares the target with the middle element.\n"
                      "(O(log n) average time).",
                  animation: "assets/animations/binary8.json",
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _arrayController,
                decoration: const InputDecoration(
                  labelText: 'Enter an array (comma-separated)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. 1,3,4,7,11,12',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _targetController,
                decoration: const InputDecoration(
                  labelText: 'Enter the target number to find',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. 7',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.inverseSurface),
                ),
                onPressed: _computeSteps,
                child: Text(
                  'Compute Binary Search Steps',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _hasSteps
                      ? AlgorithmVisualization(step: _steps[_currentStep])
                      : const Center(
                          child: Text(
                            'No steps yet.\nEnter the array & target, then tap the button!',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              _buildControls(),
            ],
          ),
        ),
      ),
    );
  }
}
