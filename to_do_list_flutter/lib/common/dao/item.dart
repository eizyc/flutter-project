import 'dart:core';


class Item {
  String title;
  String content;
  DateTime? deadline;
  DateTime createTime;

  Item({required this.title, required this.content, required this.createTime, this.deadline});
}