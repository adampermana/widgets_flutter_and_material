import 'package:flutter/material.dart';

const Duration kSnackBarDuration = Duration(milliseconds: 1000);

class SuccessSnackBar extends SnackBar {
  final String message;

  SuccessSnackBar({
    Key? key,
    required this.message,
    SnackBarAction? snackBarAction,
    EdgeInsetsGeometry? margin,
  }) : super(
          key: key,
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          backgroundColor: Colors.green,
          duration: kSnackBarDuration,
          action: snackBarAction,
          behavior: SnackBarBehavior.floating,
          margin: margin?.add(const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0)),
        );
}
