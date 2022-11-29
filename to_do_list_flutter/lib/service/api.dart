import 'dart:developer';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:to_do_list_flutter/common/dao/item.dart';

const base = "to-do-list-flutter-service.yizhichen98.workers.dev";

class API {
  static Future<List<Item>> getList() async {
    try {
      Response response = await get(Uri.https(base, 'list'));
      Utf8Decoder decode = const Utf8Decoder();
      Map res = jsonDecode(decode.convert(response.bodyBytes));
      List<dynamic> list = res['data']['list'];
      return list.map((e) => Item.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<Item> getDetail(id) async {
    Response response = await get(Uri.https(base, 'detail', {"id": id}));
    Utf8Decoder decode = const Utf8Decoder();
    Map res = jsonDecode(decode.convert(response.bodyBytes));
    dynamic data = res['data']['data'];
    return Item.fromJson(data);
  }

  static Future<bool> add(Item item) async {
    Response response = await post(Uri.https(base, 'add'),
        body: item.toRawJson(), headers: {'Content-Type': 'application/json'});
    Map res = jsonDecode(response.body);
    bool data = res['success'];
    return data;
  }

  static Future<bool> remove(String id) async {
    Response response = await delete(Uri.https(base, 'delete', {"id": id}),
        body: jsonEncode({"id": id}),
        headers: {'Content-Type': 'application/json'});
    Map res = jsonDecode(response.body);
    bool data = res['success'];
    return data;
  }
}
