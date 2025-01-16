import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' show Platform;

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
        icon: Platform.isIOS
            ? const Icon(
                Icons.arrow_back_ios,
                size: 50,
              )
            : const Icon(
                Icons.arrow_back,
                size: 50,
              ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
