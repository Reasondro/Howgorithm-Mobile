import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howgorithm/models/destination.dart';
import 'package:howgorithm/router/routes.dart';
import 'package:howgorithm/extensions/go_router_location_extension.dart';

class LayoutScaffoldWithNav extends StatelessWidget {
  const LayoutScaffoldWithNav({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    AppBar appBar;

    switch (GoRouter.of(context).location) {
      case Routes.homeScreen:
        appBar = AppBar(
          title: const Text("Home"),
        );
        break;
      case Routes.algorithmsScreen:
        appBar = AppBar(
          title: const Text("Algorithms"),
        );
        break;
      case Routes.profileScreen:
        appBar = AppBar(
          title: const Text("Profile"),
        );
        break;
      default:
        appBar = AppBar(
          title: const Text(""),
        );
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
