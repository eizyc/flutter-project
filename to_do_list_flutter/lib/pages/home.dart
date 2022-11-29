import 'package:flutter/material.dart' hide Colors;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_list_flutter/common/components/item_card.dart';
import 'package:to_do_list_flutter/common/dao/item.dart';
import 'package:to_do_list_flutter/common/dao/option.dart';
import 'package:to_do_list_flutter/common/style.dart';
import 'package:to_do_list_flutter/common/components/filter.dart';
import 'package:to_do_list_flutter/common/utils.dart';
import 'package:to_do_list_flutter/pages/popup/add.dart';
import 'package:to_do_list_flutter/service/api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String _selectedFilter = '';
  List<Item> list = [
    Item(
        title: 'Design Logo',
        content: 'Make logo for the mini project',
        createTime: DateTime.parse("2021-12-22 11:47:00"),
        deadline: DateTime.parse("2021-12-23 11:47:00")),
    Item(
        title: 'Make UI Design',
        content:
            'Make Ui design for the mini project post figma link to the trello using ..Make Ui design for the mini project post figma link to the trello using ...',
        createTime: DateTime.now()),
    Item(
        title: 'Design Logo',
        content: 'Make logo for the mini project',
        createTime: DateTime.parse("2018-02-26 10:09:00"),
        deadline: DateTime.parse("2018-02-27 10:09:00")),
    Item(
        title: 'Make UI Design',
        content:
            'Make Ui design for the mini project post figma link to the trello using ...',
        createTime: DateTime.now()),
    Item(
        title: 'Design Logo',
        content: 'Make logo for the mini project',
        createTime: DateTime.parse("2022-12-22 11:47:00"),
        deadline: DateTime.parse("2022-12-23 11:47:00")),
    Item(
        title: 'Make UI Design',
        content:
            'Make Ui design for the mini project post figma link to the trello using ...',
        createTime: DateTime.now()),
  ];
  List<Item> sortedList = [];
  final List<Option> options = ["All", "ByTime", "Deadline"]
      .map((String item) => Option(label: item, value: item))
      .toList();

  sortList(str) {
    if (str == "All") {
      setState(() {
        sortedList = List.from(list);
      });
    } else if (str == "ByTime") {
      List<Item> temp = List.from(list);
      temp.sort((a, b) => a.createTime.compareTo(b.createTime));
      setState(() {
        sortedList = temp;
      });
    } else if (str == "Deadline") {
      List<Item> temp = List.from(list);
      temp.sort((a, b) {
        if (a.deadline != null && b.deadline != null) {
          return a.deadline!.compareTo(b.deadline!);
        } else if (a.deadline != null) {
          return -1;
        } else if (b.deadline != null) {
          return 1;
        } else {
          return a.createTime.compareTo(b.createTime);
        }
      });
      setState(() {
        sortedList = temp;
      });
    }
  }

  getList() async {
    var data = await API.getList();
    setState(() {
      list = data;
      sortedList = List.from(list);
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: const Color(0x00000000),
          elevation: 0,
          title: const Text('TO DO LIST',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.primaryValue,
                  fontFamily: 'BebasNeue')),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.primaryDarkValue),
              tooltip: 'Setting',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a Setting')));
              },
            ),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 24.0, right: 24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/list_icon.png',
                      width: 25.0, height: 25.0, fit: BoxFit.contain),
                  const SizedBox(width: 10.0),
                  const Expanded(
                    flex: 1,
                    child: Text("LIST OF TODO",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.primaryLightValue,
                          fontFamily: 'BebasNeue',
                        )),
                  ),
                  MyFilter(
                      onSelected: (str) {
                        sortList(str);
                        setState(() {
                          _selectedFilter = str;
                        });
                      },
                      options: options,
                      initialValue: "All",
                      child: const Icon(Icons.filter_alt_outlined,
                          color: Colors.primaryValue, size: 24))
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                flex: 1,
                child: ListView(
                  children: sortedList
                      .map((e) => ItemCard(item: e, refresh: getList))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const Add(),
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
          if (result?['refresh'] != null) getList();
        },
        backgroundColor: Colors.primaryValue,
        tooltip: 'Add',
        child: const Icon(Icons.add, size: 48.0),
      ),
    );
  }
}
