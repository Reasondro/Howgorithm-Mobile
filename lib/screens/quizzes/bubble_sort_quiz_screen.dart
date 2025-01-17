import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

class _BubbleSortStep {
  final int i;
  final int j;
  final List<double> arrSnapshot;
  final bool shouldSwap;

  _BubbleSortStep({
    required this.i,
    required this.j,
    required this.arrSnapshot,
    required this.shouldSwap,
  });
}

class BubbleSortQuizScreen extends StatefulWidget {
  const BubbleSortQuizScreen({super.key});

  @override
  State<BubbleSortQuizScreen> createState() => _BubbleSortQuizScreenState();
}

class _BubbleSortQuizScreenState extends State<BubbleSortQuizScreen> {
  final user = Supabase.instance.client.auth.currentUser;

  late int _bubbleScore;
  late int _totalScore;

  final List<double> _arr = []; // NEW: random array

  int _score = 0;
  bool _quizFinished = false;

  final List<_BubbleSortStep> _steps = [];
  int _currentStepIndex = 0;

  @override
  void initState() {
    super.initState();

    final rand = Random();
    final length = rand.nextInt(5) + 5;
    final Set<int> tempSet = {};
    while (tempSet.length < length) {
      tempSet.add(rand.nextInt(50) + 1);
    }
    _arr.addAll(tempSet.map((e) => e.toDouble()).toList());
    _arr.shuffle();

    _generateSteps();
    _fetchUserScore();
  }

  Future<void> _fetchUserScore() async {
    final response = await Supabase.instance.client
        .from("progress")
        .select("bubble_score,total_score")
        .eq("id", user!.id)
        .single();

    // NEW: Assign to _bubbleScore (instead of _binaryScore)
    _bubbleScore = response["bubble_score"];
    _totalScore = response["total_score"];
  }

  Future<void> _updateUserScoreInDB(int score) async {
    await Supabase.instance.client.from('progress').update({
      'bubble_score': _bubbleScore + score, // NEW
      'total_score': _totalScore + score
    }).match({"id": user!.id});
  }

  void _generateSteps() {
    _steps.clear();

    final arr = List<double>.from(_arr);
    final n = arr.length;

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        final snapshotBefore = List<double>.from(arr);
        final shouldSwap = arr[j] > arr[j + 1];

        _steps.add(_BubbleSortStep(
          i: i,
          j: j,
          arrSnapshot: snapshotBefore,
          shouldSwap: shouldSwap,
        ));

        if (shouldSwap) {
          final temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;
        }
      }
    }
  }

  void _onAnswer(String userChoice) {
    if (_quizFinished || _steps.isEmpty) return;

    final step = _steps[_currentStepIndex];

    final correct = step.shouldSwap ? "Yes" : "No";

    if (userChoice == correct) {
      _score++;
    } else {
      _score--;
    }

    _currentStepIndex++;
    if (_currentStepIndex >= _steps.length) {
      setState(() {
        _quizFinished = true;
      });
    } else {
      setState(() {});
    }
  }

  void _endQuizAndUpdateDB() {
    // Update DB with bubble score
    _updateUserScoreInDB(_score);
    GoRouter.of(context).pop();
  }

  Widget _buildQuizStep(_BubbleSortStep step) {
    final j = step.j;
    final arr = step.arrSnapshot;
    final a = arr[j];
    final b = arr[j + 1];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bubble Sort Quiz',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'We are sorting a random array of length ${_arr.length}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Score: $_score',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _buildArrayVisualization(step, key: ValueKey(step)),
          ),
          const SizedBox(height: 24),
          Text(
            "Compare arr[$j] = ${a.toStringAsFixed(2)}\n"
            "with arr[${j + 1}] = ${b.toStringAsFixed(2)}.\n\n"
            "Should we swap them?",
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _onAnswer("No"),
                icon: const Icon(Icons.close),
                label: const Text(
                  'No',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _onAnswer("Yes"),
                icon: const Icon(Icons.check),
                label: const Text(
                  'Yes',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuizFinished() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          color: Theme.of(context).colorScheme.surfaceContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Quiz Finished!',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You got $_score points!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _endQuizAndUpdateDB,
                  child: const Text('Close Quiz'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArrayVisualization(_BubbleSortStep step, {Key? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(step.arrSnapshot.length, (i) {
            bool isCompared = (i == step.j || i == step.j + 1);

            Color boxColor = isCompared ? Colors.orange : Colors.grey[700]!;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                step.arrSnapshot[i].toStringAsFixed(2),
                style: const TextStyle(color: Colors.white),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_quizFinished || _steps.isEmpty) {
      content = _buildQuizFinished();
    } else {
      final step = _steps[_currentStepIndex];
      content = _buildQuizStep(step);
    }

    return Scaffold(
      appBar: const AlgorithmAppBar(),
      body: content,
    );
  }
}
