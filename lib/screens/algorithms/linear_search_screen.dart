import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'package:howgorithm/widgets/algorithm_card.dart';
import 'package:howgorithm/extensions/snackbar_extension.dart';
import 'package:howgorithm/widgets/algorithm_visualization.dart';

// ? model for linear search steps
class _LinearSearchStep {
  final List<double> arraySnapshot;
  final String description;

  //? indices to highlight (e.g. cman si  [i])
  final List<int> highlightIndices;

  _LinearSearchStep(
    this.arraySnapshot,
    this.description, {
    this.highlightIndices = const [],
  });
}

class LinearSearchScreen extends StatefulWidget {
  const LinearSearchScreen({super.key});

  @override
  State<LinearSearchScreen> createState() => _LinearSearchScreenState();
}

class _LinearSearchScreenState extends State<LinearSearchScreen> {
  final TextEditingController _arrayController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  List<_LinearSearchStep> _steps = [];
  int _currentStep = 0;

  bool get _hasSteps => _steps.isNotEmpty;

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
          label: const Icon(Icons.skip_previous_outlined, size: 40),
        ),
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
          label: const Icon(Icons.skip_next_outlined, size: 40),
        ),
      ],
    );
  }

  //? parse inputs, then run step-by-step Linear search
  void _computeSteps() {
    final rawArray = _arrayController.text.trim();
    final rawTarget = _targetController.text.trim();

    if (rawArray.isEmpty || rawTarget.isEmpty) {
      context.customShowErrorSnackBar('Please enter both array and target!');
      return;
    }

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

    final targetVal = double.tryParse(rawTarget);
    if (targetVal == null) {
      context.customShowErrorSnackBar('Please enter a valid target!');
      return;
    }

    _steps = _linearSearchWithSnapshots(doubleList, targetVal);
    _currentStep = 0;
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  //? return list of linear search
  List<_LinearSearchStep> _linearSearchWithSnapshots(
    List<double> arr,
    double target,
  ) {
    final steps = <_LinearSearchStep>[];

    //? first step ➡️ show the initial array
    steps.add(
      _LinearSearchStep(
        List<double>.from(arr),
        'Initial array:\n[${arr.join(", ")}]',
      ),
    );

    for (int i = 0; i < arr.length; i++) {
      // ?  highlighting index i
      steps.add(
        _LinearSearchStep(
          List<double>.from(arr),
          'Comparing arr[$i] = ${arr[i]} with $target',
          highlightIndices: [i],
        ),
      );

      if (arr[i] == target) {
        // ? found
        steps.add(
          _LinearSearchStep(
            List<double>.from(arr),
            'Found $target at index [$i]',
            highlightIndices: [i],
          ),
        );
        return steps;
      }
    }

    //?  ff  finish the loop but not found
    steps.add(
      _LinearSearchStep(
        List<double>.from(arr),
        '$target not found in the array!',
        highlightIndices: [],
      ),
    );
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
                  title: "Linear Search",
                  description:
                      "A simple linear search that checks each element one by one,\n"
                      "until the target is found (or not found at all).\n"
                      "(O(n) average time).",
                  animation: "assets/animations/linear5.json",
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _arrayController,
                decoration: const InputDecoration(
                  labelText: 'Enter an array (comma-separated)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. 5,3,7,9,11',
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

              // Compute steps button
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
                onPressed: _computeSteps,
                child: Text(
                  'Compute Linear Search Steps',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Visualization
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
