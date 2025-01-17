import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howgorithm/widgets/algorithm_app_bar.dart';
// import 'package:supabase_flutter/supabase_flutter.dart'; // Pseudocode for database

class BinarySearchQuizScreen extends StatefulWidget {
  const BinarySearchQuizScreen({Key? key}) : super(key: key);

  @override
  State<BinarySearchQuizScreen> createState() => _BinarySearchQuizScreenState();
}

class _BinarySearchQuizScreenState extends State<BinarySearchQuizScreen> {
  // Example array (sorted); in a real quiz, might come from user input or be randomized
  final List<double> _arr = [1, 3, 5, 9, 12, 18, 21, 25];
  final double _target = 12; // The user is trying to find this number

  int _low = 0;
  int _high = 0;
  int _mid = 0;

  int _score = 0;
  bool _quizFinished = false;

  // We’ll store the steps so that we can show them or quickly debug if needed
  final List<_BinarySearchStep> _steps = [];
  int _currentStepIndex = 0;

  @override
  void initState() {
    super.initState();
    _high = _arr.length - 1;
    _generateSteps();
    // For demonstration, let's also show how you'd fetch the user's current score from Supabase.
    _fetchUserScore();
  }

  /// Pseudo-function to demonstrate how you’d fetch the user’s current score from Supabase
  Future<void> _fetchUserScore() async {
    // final user = Supabase.instance.client.auth.currentUser;
    // if (user == null) return;

    // final response = await Supabase.instance.client
    //     .from("progress")
    //     .select("binary_score, total_score")
    //     .eq("id", user.id)
    //     .single();
    // if (response.error == null && response.data != null) {
    //   // For example:
    //   final data = response.data;
    //   final currentBinaryScore = data['binary_score'] as int;
    //   final currentTotalScore = data['total_score'] as int;
    //   // Use these as needed
    // }
  }

  /// Pseudo-function to demonstrate how you'd update the user’s new score in Supabase
  Future<void> _updateUserScoreInDB(int newBinaryScore) async {
    // final user = Supabase.instance.client.auth.currentUser;
    // if (user == null) return;

    // final response = await Supabase.instance.client
    //     .from("progress")
    //     .update({
    //       'binary_score': newBinaryScore,
    //       'total_score': ... // current total + or - ...
    //     })
    //     .eq("id", user.id);
    // if (response.error != null) {
    //   // handle error
    // }
  }

  /// Generate the step-by-step flow of the binary search
  void _generateSteps() {
    // We won't simulate the entire search at once; let's store each step:
    int low = _low;
    int high = _high;

    _steps.clear();

    // We'll keep stepping until we find the target or exhaust the search
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
    // If we never found the target in this example, so be it (quiz ends anyway)
  }

  /// Called when the user picks "Left" or "Right"
  void _onAnswer(String direction) {
    if (_quizFinished) return;

    final step = _steps[_currentStepIndex];
    final midValue = step.arrSnapshot[step.mid];

    // Determine the CORRECT direction
    // If arr[mid] < target => correct direction is "Right"
    // If arr[mid] > target => correct direction is "Left"
    // If arr[mid] == target => quiz ends
    String correct;
    if (midValue == _target) {
      correct = "Found";
    } else if (midValue < _target) {
      correct = "Right";
    } else {
      correct = "Left";
    }

    if (correct == "Found") {
      // The user actually can't pick left/right here,
      // but let's handle just in case
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

    // Move to next step
    _currentStepIndex++;
    if (_currentStepIndex >= _steps.length) {
      // Means we've reached the end (found target or exhausted search)
      setState(() {
        _quizFinished = true;
      });
    } else {
      // We continue
      setState(() {});
    }
  }

  /// If the quiz is done, we may update the DB, show a summary, etc.
  void _endQuizAndUpdateDB() {
    // For example, update supabase
    _updateUserScoreInDB(_score);

    // Then go back or show a 'results' screen
    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // If the quiz is finished or we have no steps, show results
    if (_quizFinished || _steps.isEmpty) {
      return _buildQuizFinished();
    }

    final step = _steps[_currentStepIndex];
    final midIndex = step.mid;
    final midValue = step.arrSnapshot[midIndex];

    return _buildQuizStep(step, midValue);
  }

  /// Screen to show a single step (low, mid, high) and let user choose "Left" or "Right"
  Widget _buildQuizStep(_BinarySearchStep step, double midValue) {
    return Scaffold(
      appBar: const AlgorithmAppBar(),
      body: Padding(
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

            // Score display
            Text(
              'Score: $_score',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Show the array with highlights for [low, mid, high]
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _buildArrayVisualization(step, key: ValueKey(step)),
            ),
            const SizedBox(height: 24),

            // Current question
            Text(
              "At index [${step.mid}], we have ${midValue.toStringAsFixed(2)}.\n"
              "Should we go LEFT or RIGHT?",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Buttons for "Left" or "Right"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _onAnswer("Left"),
                  icon: const Icon(Icons.arrow_left),
                  label: const Text('Left'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _onAnswer("Right"),
                  icon: const Icon(Icons.arrow_right),
                  label: const Text('Right'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// When quiz is finished or we have no steps
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
                  'Your Final Score: $_score',
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

  /// Visually display the array, with [low, mid, high] highlighted
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

            // We highlight mid with orange, low with green, high with blue (example)
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
}

// A simple model to store a step in the binary search
class _BinarySearchStep {
  final int low;
  final int high;
  final int mid;

  // In case the array changes or you want to highlight certain elements
  final List<double> arrSnapshot;

  _BinarySearchStep({
    required this.low,
    required this.high,
    required this.mid,
    required this.arrSnapshot,
  });
}
