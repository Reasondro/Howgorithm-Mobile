import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class Progress {
  Progress({
    required this.id,
    required this.bubbleScore,
    required this.mergeScore,
    required this.classicalScore,
    required this.binaryScore,
    required this.totalScore,
    required this.ranked,
  });

  final String id;

  final int bubbleScore;
  final int mergeScore;

  final int classicalScore;
  final int binaryScore;

  final int totalScore;
  final String ranked;

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map["id"],
      bubbleScore: map["bubble_score"],
      mergeScore: map["merge_score"],
      classicalScore: map["classical_score"],
      binaryScore: map["binary_score"],
      totalScore: map["total_score"],
      ranked: map["ranked"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "bubble_score": bubbleScore,
      "merge_score": mergeScore,
      "classical_score": classicalScore,
      "binary_score": binaryScore,
      "total_score": totalScore,
      "ranked": ranked,
    };
  }
}
