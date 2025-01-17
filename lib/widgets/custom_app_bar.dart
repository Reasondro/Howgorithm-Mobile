import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          height: 1.0,
          color: const Color.fromARGB(33, 66, 66, 66),
        ),
      ),
    );
  }
}
