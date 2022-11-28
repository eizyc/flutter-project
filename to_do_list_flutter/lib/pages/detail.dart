import 'package:flutter/material.dart' hide Colors;
import 'package:intl/intl.dart';
import 'package:to_do_list_flutter/common/dao/item.dart';
import 'package:to_do_list_flutter/common/style.dart';
import 'package:to_do_list_flutter/pages/popup/delete.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Item item = Item(
      title: 'Make UI Design',
      content:
          'Make Ui design for the mini project post figma link to the trello using view only link. Design List : \nlogin \nregister \nhome \ndetail \nadd \nedit \ndelete \nprofile',
      createTime: DateTime.parse("2021-12-22 11:47:00"),
      deadline: DateTime.parse("2021-12-23 11:47:00"));

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
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const Delete(),
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
                    }));
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
                child: Text(item.title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.primaryDarkValue,
                      fontFamily: 'BebasNeue',
                    )),
              ),
              Expanded(
                  flex: 1,
                  child: Text(item.content,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.primaryDarkValue,
                          height: 1.7))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Created at ${DateFormat.yMMMMd('en_US').format(item.createTime)}",
                    style: const TextStyle(
                        color: Colors.primaryDarkValue, fontSize: 14),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
