import 'package:howgorithm/models/progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgressDatabase {
  final database = Supabase.instance.client.from("progress");

// ? bwah CRUD basically
// ? create
  Future createProgress(Progress newProgress) async {
    await database.insert(newProgress.toMap());
  }

// ?read
  final stream = Supabase.instance.client
      .from("progress")
      .stream(primaryKey: ["id"]).map((data) =>
          data.map((progressMap) => Progress.fromMap(progressMap)).toList());

//? update

  Future updateProgressBubbleScore(
      Progress oldProgress, int newBubbleScore) async {
    await database
        .upsert({"bubble_score": newBubbleScore}).eq("id", oldProgress.id);
  }

  Future updateProgressBinaryScore(
      Progress oldProgress, int newBinaryScore) async {
    await database
        .upsert({"binary_score": newBinaryScore}).eq("id", oldProgress.id);
  }

//? upsert

  Future upsertProgressBubbleScore(
      Progress oldProgress, int newBubbleScore) async {
    await database
        .upsert({"bubble_score": newBubbleScore}).eq("id", oldProgress.id);
  }

  Future upsertProgressBinaryScore(
      Progress oldProgress, int newBinaryScore) async {
    await database
        .upsert({"binary_score": newBinaryScore}).eq("id", oldProgress.id);
  }

  // ?delete
  Future deleteProgress(Progress progress) async {
    await database.delete().eq("id", progress.id);
  }
}
