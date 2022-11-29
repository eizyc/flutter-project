import 'dart:convert';
import 'dart:core';

class Item {
  String? id;
  String title;
  String content;
  DateTime? deadline;
  DateTime createTime;

  Item(
      {required this.title,
      required this.content,
      required this.createTime,
      this.id,
      this.deadline});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      deadline: json['deadline'] == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(json['deadline'], isUtc: true),
      createTime:
          DateTime.fromMicrosecondsSinceEpoch(json['createTime'], isUtc: true),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      "content": content,
      "deadline": deadline?.microsecondsSinceEpoch,
      "createTime": createTime.microsecondsSinceEpoch
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  String toRawJson() => jsonEncode(toJson());
}
