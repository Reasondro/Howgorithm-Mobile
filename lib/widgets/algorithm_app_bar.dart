import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'dart:io' show Platform;

class AlgorithmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AlgorithmAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      leadingWidth: 64,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.1),
        child: Container(
          height: 1.0,
          color: const Color.fromARGB(33, 66, 66, 66),
        ),
      ),
    );
  }
}
