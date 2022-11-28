import 'package:flutter/material.dart' hide Colors;
import 'package:to_do_list_flutter/common/components/button.dart';
import 'package:to_do_list_flutter/common/style.dart';

class Delete extends StatelessWidget {
  const Delete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000).withOpacity(0.5),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyButton(
              dark: false,
              text: 'Delete TODO',
              color: Colors.primaryValue,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            MyButton(
              dark: false,
              text: 'Cancel',
              color: Colors.green,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 48),
          ],
        ),
      )),
    );
  }
}
