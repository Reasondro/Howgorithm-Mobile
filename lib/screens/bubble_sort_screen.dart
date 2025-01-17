import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'package:howgorithm/widgets/algorithm_card.dart';
import 'package:howgorithm/extensions/snackbar_extension.dart';
import 'package:howgorithm/widgets/algorithm_visualization.dart';

//?? model ngestore tiap snap shot bubble sort nya + description
class _BubbleSortStep {
  final List<double> arraySnapshot;
  final String description;

  final List<int> highlightIndices;

  _BubbleSortStep(
    this.arraySnapshot,
    this.description, {
    this.highlightIndices = const [],
  });
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

  List<_BubbleSortStep> _steps = [];
  int _currentStep = 0;

  bool get _hasSteps => _steps.isNotEmpty;

  //?? parse input, run bubble sort step-by-step,  store steps
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
        return; //? or continue if you want to skip invalid
      }
    }

    _steps = _bubbleSortWithSnapshots(doubleList);
    _currentStep = 0;
    setState(() {});
  }

  //?? return list of all intermediate steps (array snapshot + description)
  List<_BubbleSortStep> _bubbleSortWithSnapshots(List<double> inputArray) {
    final steps = <_BubbleSortStep>[];
    final arr = List<double>.from(inputArray);

    steps.add(_BubbleSortStep(
      List<double>.from(arr),
      'Initial array:\n${arr.join(", ")}',
    ));

    for (int i = 0; i < arr.length - 1; i++) {
      for (int j = 0; j < arr.length - i - 1; j++) {
        //? [NEW] highlight two indices being compared
        steps.add(_BubbleSortStep(
          List<double>.from(arr),
          'Comparing indices [$j] and [${j + 1}]:\n'
          '${arr[j]} & ${arr[j + 1]}',
          highlightIndices: [j, j + 1],
        ));

        if (arr[j] > arr[j + 1]) {
          //? swap
          final temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;

          //? [NEW] highlight  same indices after swap
          steps.add(_BubbleSortStep(
            List<double>.from(arr),
            'Swapped elements at indices [$j] and [${j + 1}]:\n'
            '${arr[j]} <-> ${arr[j + 1]}',
            highlightIndices: [j, j + 1],
          ));
        }
      }

      steps.add(_BubbleSortStep(
        List<double>.from(arr),
        'End of loop ${i + 1}',
      ));
    }

    return steps;
  }

  // TODO modularize this
  //?? build Previous/Next buttons + step indicator
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
                  // iconData: Icons.bubble_chart_outlined,
                  animation: "assets/animations/bubble3.json",
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter an array (comma-separated)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. 5,1,51,5.5,16.3',
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
                      ? algorithmVisualization(_steps[_currentStep])
                      : const Center(
                          child: Text(
                            'No steps yet.\nEnter an array and tap the button!',
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
