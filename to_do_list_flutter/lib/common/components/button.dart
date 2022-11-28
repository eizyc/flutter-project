import 'package:flutter/material.dart' hide Colors;
import 'package:to_do_list_flutter/common/style.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool dark;
  final Color? color;
  final void Function()? onPressed;

  const MyButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.dark = true,
      this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: dark ? Colors.primaryLightValue : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 14,
                color: color ??
                    (dark ? Colors.white : Colors.primaryLightValue))));
  }
}
