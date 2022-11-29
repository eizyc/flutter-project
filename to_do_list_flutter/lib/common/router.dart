import 'package:flutter/material.dart';
import 'package:to_do_list_flutter/pages/login.dart';
import 'package:to_do_list_flutter/pages/home.dart';
import 'package:to_do_list_flutter/pages/detail.dart';
import 'package:to_do_list_flutter/pages/popup/delete.dart';
import 'package:to_do_list_flutter/pages/popup/add.dart';
import 'package:to_do_list_flutter/pages/user.dart';

class RouteGenerator {
  static Map<String, WidgetBuilder> initRoutes = {
    '/login': (context) => const Login(),
    '/home': (context) => const Home(),
    '/add': (context) => const Add(),
    '/detail': (context) => const Detail(),
    '/delete': (context) => const Delete(),
    '/user': (context) => const User(),
  };

  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    final String name = settings.name ?? '';
    Map<String, WidgetBuilder> routes = initRoutes;
    Function? builder = routes[name];
    builder ??= () => const Scaffold(
          body: Text("no this path"),
        );
    return MaterialPageRoute(
      builder: (BuildContext context) => builder!(context),
      settings: RouteSettings(name: name, arguments: settings.arguments ?? {}),
    );
  }
}
