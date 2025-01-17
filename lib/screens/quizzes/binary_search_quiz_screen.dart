import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:howgorithm/widgets/algorithm_app_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

class _BinarySearchStep {
  final int low;
  final int high;
  final int mid;

  final List<double> arrSnapshot;

  _BinarySearchStep({
    required this.low,
    required this.high,
    required this.mid,
    required this.arrSnapshot,
  });
}

class BinarySearchQuizScreen extends StatefulWidget {
  const BinarySearchQuizScreen({super.key});

  @override
  State<BinarySearchQuizScreen> createState() => _BinarySearchQuizScreenState();
}

class _BinarySearchQuizScreenState extends State<BinarySearchQuizScreen> {
  final user = Supabase.instance.client.auth.currentUser;

  late int _binaryScore;
  late int _totalScore;

  final List<double> _arr = [];
  late double _target;

  int _low = 0;
  int _high = 0;

  int _score = 0;
  bool _quizFinished = false;

  final List<_BinarySearchStep> _steps = [];
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
    _arr.sort();

    final randomIndex = rand.nextInt(_arr.length);
    _target = _arr[randomIndex];
    _high = _arr.length - 1;
    _generateSteps();
    _fetchUserScore();
  }

  Future<void> _fetchUserScore() async {
    final response = await Supabase.instance.client
        .from("progress")
        .select("binary_score,total_score")
        .eq("id", user!.id)
        .single();

    _binaryScore = response["binary_score"];
    _totalScore = response["total_score"];
  }

  Future<void> _updateUserScoreInDB(int score) async {
    await Supabase.instance.client.from('progress').update({
      'binary_score': _binaryScore + score,
      'total_score': _totalScore + score
    }).match({"id": user!.id});
  }

  void _generateSteps() {
    int low = _low;
    int high = _high;

    _steps.clear();

    while (low <= high) {
      final mid = (low + high) ~/ 2;
      _steps.add(_BinarySearchStep(
        low: low,
        high: high,
        mid: mid,
        arrSnapshot: List<double>.from(_arr),
      ));

      if (_arr[mid] == _target) {
        // Found
        break;
      } else if (_arr[mid] < _target) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
  }

  void _onAnswer(String direction) {
    if (_quizFinished) return;

    final step = _steps[_currentStepIndex];
    final midValue = step.arrSnapshot[step.mid];

    String correct;
    if (midValue == _target) {
      correct = "Found";
    } else if (midValue < _target) {
      correct = "Right";
    } else {
      correct = "Left";
    }

    if (correct == "Found") {
      setState(() {
        _quizFinished = true;
      });
      return;
    }

    if (direction == correct) {
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
      // We continue
      setState(() {});
    }
  }

  void _endQuizAndUpdateDB() {
    _updateUserScoreInDB(_score);
    GoRouter.of(context).pop();
  }

  Widget _buildQuizStep(_BinarySearchStep step, double midValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Binary Search Quiz',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'We are looking for $_target',
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
            "At index [${step.mid}], we have ${midValue.toStringAsFixed(2)}.\n"
            "Should we go LEFT or RIGHT?",
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                style: const ButtonStyle(iconSize: WidgetStatePropertyAll(48)),
                onPressed: () => _onAnswer("Left"),
                icon: const Icon(Icons.arrow_left),
                label: const Text(
                  'Left',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              ElevatedButton.icon(
                style: const ButtonStyle(iconSize: WidgetStatePropertyAll(48)),
                onPressed: () => _onAnswer("Right"),
                icon: const Icon(Icons.arrow_right),
                label: const Text(
                  'Right',
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

  Widget _buildArrayVisualization(_BinarySearchStep step, {Key? key}) {
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
            bool isLow = (i == step.low);
            bool isHigh = (i == step.high);
            bool isMid = (i == step.mid);

            Color boxColor;
            if (isMid) {
              boxColor = Colors.orange;
            } else if (isLow) {
              boxColor = Colors.green;
            } else if (isHigh) {
              boxColor = Colors.blue;
            } else {
              boxColor = Colors.grey[700]!;
            }

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
    final step = _steps[_currentStepIndex];
    final midIndex = step.mid;
    final midValue = step.arrSnapshot[midIndex];

    if (_quizFinished || _steps.isEmpty) {
      content = _buildQuizFinished();
    } else {
      content = _buildQuizStep(step, midValue);
    }

    return Scaffold(
      appBar: const AlgorithmAppBar(),
      body: content,
    );
  }
}
