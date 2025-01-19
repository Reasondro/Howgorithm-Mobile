import 'package:flutter/material.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'package:howgorithm/widgets/algorithm_card.dart';
import 'package:howgorithm/extensions/snackbar_extension.dart';
import 'package:howgorithm/widgets/algorithm_visualization.dart';

// ?? model for storing tiap snapshot merge sort step nya + description
class _MergeSortStep {
  final List<double> arraySnapshot;
  final String description;

  //? indices to highlight (➡️ subarray [left..right])
  final List<int> highlightIndices;

  _MergeSortStep(
    this.arraySnapshot,
    this.description, {
    this.highlightIndices = const [],
  });
}

class MergeSortScreen extends StatefulWidget {
  const MergeSortScreen({super.key});

  @override
  State<MergeSortScreen> createState() => _MergeSortScreenState();
}

class _MergeSortScreenState extends State<MergeSortScreen> {
  final TextEditingController _controller = TextEditingController();

  //?  step-by-step snapshots
  List<_MergeSortStep> _steps = [];
  int _currentStep = 0;

  bool get _hasSteps => _steps.isNotEmpty;

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
        return;
      }
    }

    //?  merge sort steps
    _steps = _mergeSortWithSnapshots(doubleList);

    //? reset to  first step
    _currentStep = 0;
    setState(() {});
  }

  //? return  list of all intermediate steps during merge sort (the main thing basically)
  List<_MergeSortStep> _mergeSortWithSnapshots(List<double> inputArray) {
    final steps = <_MergeSortStep>[];
    final arr = List<double>.from(inputArray);

    //? record  initial state
    steps.add(
      _MergeSortStep(
        List<double>.from(arr),
        'Initial array:\n[${arr.join(", ")}]',
      ),
    );

    //? recursive function to split and merge
    void mergeSort(List<double> array, int left, int right) {
      if (left < right) {
        final mid = (left + right) ~/ 2;

        //? sort left half
        mergeSort(array, left, mid);
        // ? sort right half
        mergeSort(array, mid + 1, right);

        // ?merge the two halves
        _merge(array, left, mid, right, steps);
      }
    }

    //? perform the sort on arr
    mergeSort(arr, 0, arr.length - 1);

    return steps;
  }

  //? merge two sorted subarrays [left..mid], [mid+1..right]
  //? and record each merge as a step
  void _merge(
    List<double> arr,
    int left,
    int mid,
    int right,
    List<_MergeSortStep> steps,
  ) {
    //?  highlighting, gather all indices from left..right
    final highlight = <int>[];
    for (int i = left; i <= right; i++) {
      highlight.add(i);
    }

    //? prep temp arrays
    final n1 = mid - left + 1;
    final n2 = right - mid;

    final leftPart = List<double>.filled(n1, 0);
    final rightPart = List<double>.filled(n2, 0);

    for (int i = 0; i < n1; i++) {
      leftPart[i] = arr[left + i];
    }
    for (int j = 0; j < n2; j++) {
      rightPart[j] = arr[mid + 1 + j];
    }

    //? merge them back into arr[left..right]
    int i = 0; //? index for leftPart
    int j = 0; //? index for rightPart
    int k = left; //? index for merged array

    while (i < n1 && j < n2) {
      if (leftPart[i] <= rightPart[j]) {
        arr[k] = leftPart[i];
        i++;
      } else {
        arr[k] = rightPart[j];
        j++;
      }
      k++;
    }

    //? copy remaining elements of leftPart
    while (i < n1) {
      arr[k] = leftPart[i];
      i++;
      k++;
    }

    //? copy remaining elements of rightPart
    while (j < n2) {
      arr[k] = rightPart[j];
      j++;
      k++;
    }

    // ? record snapshot after merging
    steps.add(
      _MergeSortStep(
        List<double>.from(arr),
        'Merged subarrays [$left..$mid] & [${mid + 1}..$right]',
        highlightIndices: highlight,
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AlgorithmAppBar(),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: AlgorithmCard(
                  title: "Merge Sort",
                  description:
                      "Merge Sort is a divide-and-conquer algorithm. It recursively divides the array in half, sorts each half, and then merges the sorted halves.\n(O(n log n) average time).",
                  animation:
                      "assets/animations/merge1.json", // You can pick any animation asset
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter an array (comma-separated)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. 10,5,2,9,15,13,11',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
                onPressed: _computeSteps,
                child: Text(
                  'Compute Merge Sort Steps',
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
