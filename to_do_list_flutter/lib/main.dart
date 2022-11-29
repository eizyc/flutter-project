import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list_flutter/pages/login.dart';
import 'package:to_do_list_flutter/pages/home.dart';
import 'package:to_do_list_flutter/pages/detail.dart';
import 'package:to_do_list_flutter/pages/popup/delete.dart';
import 'package:to_do_list_flutter/pages/popup/add.dart';
import 'package:to_do_list_flutter/common/components/hide_keyboard.dart';
import 'package:to_do_list_flutter/pages/user.dart';

void main() {
  runApp(HideKeyboard(
    child: MaterialApp(
        initialRoute: '/home',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness:
                  Brightness.dark, //for andriod black status bar
              statusBarBrightness: Brightness.light, //for iOS black status bar
            ),
          ),
          fontFamily: "Montserrat",
          primaryColor: const Color(0xFFF76C6A),
        ),
        routes: {
          '/login': (context) => const Login(),
          '/home': (context) => Home(),
          '/add': (context) => const Add(),
          '/detail': (context) => const Detail(),
          '/delete': (context) => const Delete(),
          '/user': (context) => const User(),
        }),
  ));
}
