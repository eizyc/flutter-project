import 'package:flutter/material.dart' hide Colors;
import 'package:intl/intl.dart';
import 'package:to_do_list_flutter/common/dao/item.dart';
import 'package:to_do_list_flutter/common/style.dart';
import 'package:to_do_list_flutter/common/utils.dart';
import 'package:to_do_list_flutter/pages/popup/delete.dart';
import 'package:to_do_list_flutter/service/api.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Item? item;
  String id = "";

  getDetail(String id) async {
    var data = await API.getDetail(id);
    setState(() {
      item = data;
    });
  }

  @override
  void initState() {
    super.initState();
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    String temp = args['id'];
    getDetail(temp);
    setState(() {
      id = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: const Color(0x00000000),
          elevation: 0,
          foregroundColor: Colors.primaryDarkValue,
          actions: <Widget>[
            InkWell(
              onTap: () {},
              child: const Icon(Icons.edit_outlined,
                  color: Colors.primaryDarkValue),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Delete(id: id),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      }),
                );
              },
              child: const Icon(Icons.delete_outline_rounded,
                  color: Colors.primaryDarkValue),
            ),
            const SizedBox(width: 16)
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: item?.title != null
                    ? Text(item!.title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.primaryDarkValue,
                          fontFamily: 'BebasNeue',
                        ))
                    : const SizedBox.shrink(),
              ),
              Expanded(
                  flex: 1,
                  child: Text(item?.content ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.primaryDarkValue,
                          height: 1.7))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  item?.createTime != null
                      ? Text(
                          "Created at ${DateFormat.yMMMMd('en_US').format(item!.createTime)}",
                          style: const TextStyle(
                              color: Colors.primaryDarkValue, fontSize: 14),
                        )
                      : const SizedBox.shrink()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
