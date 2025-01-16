import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howgorithm/screens/algorithms_screen.dart';
import 'package:howgorithm/screens/auth_screen.dart';

import 'package:howgorithm/screens/home_screen.dart';
// import 'package:howgorithm/screens/lab_screen.dart';
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
                // builder: (context, state) => const HomeScreen(),
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: HomeScreen());
                },
              ),
            ],
          ),
          StatefulShellBranch(routes: [
            GoRoute(
                name: "Algorithms",
                path: Routes.algorithmsScreen,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: AlgorithmsScreen(),
                  );
                }),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                name: "Profile",
                path: Routes.profileScreen,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: ProfileScreen());
                  // return NoTransitionPage(child: NoteScreen());
                }),
          ])
        ],
      ),
      GoRoute(
          path: Routes.authScreen,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: AuthScreen());
          })
    ],
  );
}
