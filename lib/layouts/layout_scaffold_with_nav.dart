import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howgorithm/models/destination.dart';
import 'package:howgorithm/router/routes.dart';
import 'package:howgorithm/extensions/go_router_location_extension.dart';
import 'package:howgorithm/widgets/custom_app_bar.dart';

class LayoutScaffoldWithNav extends StatelessWidget {
  const LayoutScaffoldWithNav({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    CustomAppBar appBar;

    switch (GoRouter.of(context).location) {
      case Routes.homeScreen:
        appBar = const CustomAppBar(title: "HOWGORITHM");
        break;
      case Routes.algorithmsScreen:
        appBar = const CustomAppBar(title: "Algorithm");
        break;
      case Routes.quizzesScreen:
        appBar = const CustomAppBar(title: "Quizzes");
        break;
      case Routes.profileScreen:
        appBar = const CustomAppBar(title: "Profile");
        break;
      default:
        appBar = const CustomAppBar(title: "");
    }

    return Scaffold(
      appBar: appBar,
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        destinations: destinations
            .map(
              (d) => NavigationDestination(
                icon: Icon(d.icon),
                label: d.label,
                selectedIcon: Icon(
                  d.icon,
                ),
              ),
            )
            .toList(),
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
      ),
    );
  }
}
