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
          // Avatar (unchanged)
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
                return const Center(child: CircularProgressIndicator());
              }
              final List<Progress> listProgress = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Progress",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.bubble_chart_outlined),
                          title: const Text('Bubble Sort Score'),
                          trailing: Text(
                            '${listProgress.first.bubbleScore}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.merge_outlined),
                          title: const Text('Merge Sort Score'),
                          trailing: Text(
                            '${listProgress.first.mergeScore}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.search_outlined),
                          title: const Text('Classical Search Score'),
                          trailing: Text(
                            '${listProgress.first.classicalScore}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.switch_left_outlined),
                          title: const Text('Binary Search Score'),
                          trailing: Text(
                            '${listProgress.first.binaryScore}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.star_outline),
                          title: const Text('Total Score'),
                          trailing: Text(
                            '${listProgress.first.totalScore}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.leaderboard_outlined),
                          title: const Text('Ranked'),
                          trailing: Text(
                            listProgress.first.ranked,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 16),

          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Sign out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              onPressed: () {
                AuthService().signOut();
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
