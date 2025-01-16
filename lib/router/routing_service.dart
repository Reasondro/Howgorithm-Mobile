import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howgorithm/screens/algorithms_screen.dart';
import 'package:howgorithm/screens/auth_screen.dart';
import 'package:howgorithm/screens/binary_search_screen.dart';
import 'package:howgorithm/screens/bubble_sort_screen.dart';
import 'package:howgorithm/screens/classical_search_screen.dart';

import 'package:howgorithm/screens/home_screen.dart';
import 'package:howgorithm/screens/merge_sort_screen.dart';
import 'package:howgorithm/screens/profile_screen.dart';
import 'package:howgorithm/layouts/layout_scaffold_with_nav.dart';
import 'package:howgorithm/router/routes.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class RoutingService {
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.homeScreen,
    redirect: (BuildContext context, GoRouterState state) {
      final bool signedOut = Supabase.instance.client.auth.currentUser == null;
      final bool signingIn = state.matchedLocation == "/auth";

      // ? testing ⬇️⬇️⬇️⬇️⬇️
      // print(" Who is it: ${Supabase.instance.client.auth.currentUser}");
      // print("curr matched loc from routing_service: ${state.matchedLocation}");

      if (signedOut) {
        // ? testing ⬇️⬇️⬇️⬇️⬇️
        // print("curr matched loc from signedOut cond: ${state.matchedLocation}");
        return Routes.authScreen;
      }

      if (signingIn) {
        // ? testing ⬇️⬇️⬇️⬇️⬇️
        // print("curr matched loc from signingIn cond: ${state.matchedLocation}");
        return Routes.homeScreen;
      }
      // ? testing ⬇️⬇️⬇️⬇️⬇️
      // print("curr matched loc from nothing cond: ${state.matchedLocation}");

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell navigationShell) =>
            LayoutScaffoldWithNav(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: "Home",
                path: Routes.homeScreen,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(routes: [
            GoRoute(
              name: "Algorithms",
              path: Routes.algorithmsScreen,
              builder: (context, state) => const AlgorithmsScreen(),
              routes: [
                GoRoute(
                  name: "Bubble Sort",
                  parentNavigatorKey: _rootNavigatorKey,
                  path: Routes.bubbleSortScreen,
                  builder: (context, state) {
                    return const BubbleSortScreen();
                  },
                ),
                GoRoute(
                  name: "Merge Sort",
                  parentNavigatorKey: _rootNavigatorKey,
                  path: Routes.mergeSortScreen,
                  builder: (context, state) {
                    return const MergeSortScreen();
                  },
                ),
                GoRoute(
                  name: "Classical Search",
                  parentNavigatorKey: _rootNavigatorKey,
                  path: Routes.classicalSearchScreen,
                  builder: (context, state) {
                    return const ClassicalSearchScreen();
                  },
                ),
                GoRoute(
                  name: "Binary Search",
                  parentNavigatorKey: _rootNavigatorKey,
                  path: Routes.binarySearchScreen,
                  builder: (context, state) {
                    return const BinarySearchScreen();
                  },
                )
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              name: "Profile",
              path: Routes.profileScreen,
              builder: (context, state) => const ProfileScreen(),
            ),
          ])
        ],
      ),
      GoRoute(
          path: Routes.authScreen,
          builder: (context, state) => const AuthScreen())
    ],
  );
}
