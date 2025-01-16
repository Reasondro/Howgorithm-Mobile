import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void customShowErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.only(bottom: 4, top: 14, left: 14, right: 14),
        content: Text(
          message,
          style: TextStyle(
              color: Theme.of(this).colorScheme.onError, fontSize: 15),
          textAlign: TextAlign.left,
        ),
        backgroundColor: Theme.of(this).colorScheme.error,
        dismissDirection: DismissDirection.horizontal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }

  void customShowSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.only(bottom: 4, top: 14, left: 14, right: 14),
        content: Text(
          message,
          style: TextStyle(
              color: Theme.of(this).colorScheme.onPrimary, fontSize: 15),
          textAlign: TextAlign.left,
        ),
        backgroundColor: Theme.of(this).colorScheme.primary,
        dismissDirection: DismissDirection.horizontal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }
}
