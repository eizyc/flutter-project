import 'dart:developer';

import 'package:flutter/material.dart' hide Colors;
import 'package:to_do_list_flutter/common/components/button.dart';
import 'package:to_do_list_flutter/common/style.dart';
import 'package:to_do_list_flutter/common/utils.dart';
import 'package:to_do_list_flutter/service/api.dart';

class Delete extends StatelessWidget {
  final String? id;
  const Delete({super.key, this.id});

  deleteItem(ctx) async {
    if (await API.remove(id as String)) {
      await toast("Delete Success!");
      Navigator.of(ctx).popUntil((route) {
        if (route.settings.name == '/home') {
          (route.settings.arguments as Map)['refresh'] = true;
          return true;
        } else {
          return false;
        }
      });
    } else {
      toast("Delete Failure!");
    }
  }

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
              onPressed: () {
                deleteItem(context);
              },
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
