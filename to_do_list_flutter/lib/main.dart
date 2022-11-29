import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list_flutter/common/router.dart';
import 'package:to_do_list_flutter/common/components/hide_keyboard.dart';

void main() {
  runApp(HideKeyboard(
    child: MaterialApp(
        initialRoute: '/login',
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
        onGenerateRoute: RouteGenerator.routeGenerator),
  ));
}
