import 'package:flutter/material.dart';
import 'package:howgorithm/auth/auth_service.dart';
import 'package:howgorithm/database/progress_database.dart';
import 'package:howgorithm/models/progress.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProgressDatabase _progressDatabase = ProgressDatabase();

  @override
  Widget build(BuildContext context) {
    final String userEmail =
        AuthService.supabase.auth.currentUser!.email ?? "User Email";
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16.0, left: 16.0),
      child: ListView(
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/default-profile.png'),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              userEmail,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          StreamBuilder(
              stream: _progressDatabase.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final List<Progress> listProgress = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Bubble Sort Score     : ${listProgress.first.bubbleScore}"),
                    Text(
                        "Merge Sort Score      : ${listProgress.first.mergeScore}"),
                    Text(
                        "Classical Search Score: ${listProgress.first.classicalScore}"),
                    Text(
                        "Binary Search Score   : ${listProgress.first.binaryScore}"),
                    Text("Total Score: ${listProgress.first.totalScore}"),
                    Text("Ranked: ${listProgress.first.ranked}"),
                  ],
                );
              }),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              ),
              onPressed: () {
                AuthService().signOut();
              },
              child: const Text('Sign out'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
