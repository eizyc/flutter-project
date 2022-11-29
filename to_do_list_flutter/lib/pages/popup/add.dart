import 'dart:developer';

import 'package:flutter/material.dart' hide Colors;
import 'package:to_do_list_flutter/common/components/button.dart';
import 'package:to_do_list_flutter/common/components/input.dart';
import 'package:to_do_list_flutter/common/dao/item.dart';
import 'package:to_do_list_flutter/common/dao/option.dart';
import 'package:to_do_list_flutter/common/style.dart';
import 'package:to_do_list_flutter/common/utils.dart';
import 'package:to_do_list_flutter/service/api.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  AddState createState() => AddState();
}

class AddState extends State<Add> {
  double safeareaHeight = 0;
  Item item = Item(title: '测试', content: '测试', createTime: DateTime.now());
  final List<Option> options = ["All", "ByTime", "Deadline"]
      .map((String item) => Option(label: item, value: item))
      .toList();

  @override
  initState() {
    super.initState();
    safeareaHeight = MediaQuery.of(context).padding.bottom;
  }

  addItem(ctx) async {
    try {
      if (await API.add(item)) {
        await toast("Success!");
        Navigator.pop(ctx, {"refresh": true});
      } else {
        toast("Failure!");
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 100,
              color: const Color(0x00000000),
            )),
        Expanded(
          flex: 1,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            color: Colors.primaryLightValue,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                        width: 80,
                        height: 6,
                        color: Colors.white,
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                        )),
                  ),
                  MyInput(
                    onChanged: (dynamic str) => setState(() {
                      item.title = str;
                    }),
                    placeholder: "Title",
                    dark: false,
                    bolder: true,
                  ),
                  const SizedBox(height: 16.0),
                  MyInput(
                    onChanged: (dynamic str) => setState(() {
                      item.content = str;
                    }),
                    placeholder: "Description",
                    dark: false,
                    bolder: true,
                    expanded: true,
                  ),
                  const SizedBox(height: 16.0),
                  MyInput(
                    onChanged: (dynamic date) => setState(() {
                      item.deadline = date;
                    }),
                    placeholder: "Deadline (Optional)",
                    dark: false,
                    type: Type.calendar,
                  ),
                  const SizedBox(height: 16.0),
                  MyInput(
                    onChanged: (dynamic date) => setState(() {
                      item.deadline = date;
                    }),
                    placeholder: "Add Image (Optional)",
                    dark: false,
                    type: Type.image,
                  ),
                  const SizedBox(height: 16.0),
                  MyButton(
                      dark: false,
                      onPressed: () => addItem(context),
                      text: "ADD TODO"),
                  SizedBox(height: safeareaHeight),
                ]),
          ),
        )
      ],
    );
  }
}
