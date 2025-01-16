import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'package:howgorithm/widgets/algorithm_card.dart';
import 'package:howgorithm/extensions/snackbar_extension.dart';

//? A simple model to store each bubble sort step’s snapshot + description
class _BubbleSortStep {
  final List<double> arraySnapshot;
  final String description;

  _BubbleSortStep(this.arraySnapshot, this.description);
}

class BubbleSortScreen extends StatefulWidget {
  const BubbleSortScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BubbleSortScreenState();
  }
}

class _BubbleSortScreenState extends State<BubbleSortScreen> {
  final TextEditingController _controller = TextEditingController();
  //? list of step snapshots for the bubble sort
  List<_BubbleSortStep> _steps = [];
  //? current step index
  int _currentStep = 0;

  bool get _hasSteps => _steps.isNotEmpty;

  //? “visualization” portion for the current step
  Widget _buildVisualization(_BubbleSortStep step) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //? show current array snapshot
        Text(
          step.arraySnapshot.toString(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 10),
        //? show step description
        Text(
          step.description,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  //? builds Previous/Next buttons + step indicator
  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //? Previous Button
        ElevatedButton.icon(
          onPressed: _currentStep > 0
              ? () {
                  setState(() {
                    _currentStep--;
                  });
                }
              : null, //? disabled if first step
          label: const Icon(
            Icons.skip_previous_outlined,
            size: 30,
          ),
        ),

        //? step indicator (e.g. "Step 2 of 10")
        if (_hasSteps)
          Text(
            'Step ${_currentStep + 1} of ${_steps.length}',
            style: const TextStyle(fontSize: 16),
          ),

        if (!_hasSteps)
          const Text(
            '-',
            style: TextStyle(fontSize: 16),
          ),

        //? next Button
        ElevatedButton.icon(
          onPressed: _currentStep < _steps.length - 1
              ? () {
                  setState(() {
                    _currentStep++;
                  });
                }
              : null, //? disbale if last step
          label: const Icon(
            Icons.skip_next_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }

  //? parse input, run bubble sort step-by-step,  store steps
  void _computeSteps() {
    final rawInput = _controller.text.trim();
    if (rawInput.isEmpty) {
      return;
    }

    final parts = rawInput.split(',');
    final doubleList = <double>[];
    for (var p in parts) {
      final val = double.tryParse(p.trim());
      if (val != null) {
        doubleList.add(val);
      } else {
        context.customShowErrorSnackBar('Please enter a valid array');
      }
    }

    _steps = _bubbleSortWithSnapshots(doubleList);
    _currentStep = 0;
    setState(() {});
  }

  //? return list of all intermediate steps (array snapshot + description)
  List<_BubbleSortStep> _bubbleSortWithSnapshots(List<double> inputArray) {
    final steps = <_BubbleSortStep>[];

    //? copy  array --> doesnt mutate the original
    final arr = List<double>.from(inputArray);

    //? record  initial state
    steps.add(_BubbleSortStep(
      List<double>.from(arr),
      'Initial array: ${arr.join(", ")}',
    ));

    //? bubble sort
    for (int i = 0; i < arr.length - 1; i++) {
      for (int j = 0; j < arr.length - i - 1; j++) {
        //? compare arr[j] & arr[j+1]
        steps.add(_BubbleSortStep(
          List<double>.from(arr),
          'Comparing indices [$j] and [${j + 1}]:\n'
          '${arr[j]} & ${arr[j + 1]}',
        ));

        if (arr[j] > arr[j + 1]) {
          //? swap
          final temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;

          steps.add(_BubbleSortStep(
            List<double>.from(arr),
            'Swapped elements at indices [$j] and [${j + 1}]:\n'
            '${arr[j]} <-> ${arr[j + 1]}',
          ));
        }
      }

      //? end of loop
      steps.add(_BubbleSortStep(
        List<double>.from(arr),
        'End of loop ${i + 1}',
      ));
    }

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
                  title: "Bubble Sort",
                  description:
                      "Bubble Sort repeatedly traverses the list and swaps adjacent elements if they’re out of order.\n On each pass, the largest element “bubbles up” to the end of the list, and after enough passes, the entire list is sorted.\n(O(n²) average time).",
                  iconData: Icons.bubble_chart_outlined,
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter an array (comma-separated)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. 5,1,51,5,16',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.inverseSurface),
                ),
                onPressed: _computeSteps,
                child: Text(
                  'Compute Bubble Sort Steps',
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16)),
                  child: _hasSteps
                      ? _buildVisualization(_steps[_currentStep])
                      : const Center(
                          child: Text(
                            'No steps yet.\nEnter an array and tap the button!',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
              if (_hasSteps) ...[
                const SizedBox(height: 16),
                _buildControls(),
              ],
              if (!_hasSteps) ...[
                const SizedBox(height: 16),
                _buildControls(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
