import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

void Function(String) log = (msg) {
  Fluttertoast.showToast(msg: msg, timeInSecForIosWeb: 10);
};

Future<bool?> Function(String) toast = (msg) => Fluttertoast.showToast(
    msg: msg, timeInSecForIosWeb: 3, gravity: ToastGravity.CENTER);
