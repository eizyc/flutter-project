import 'dart:developer';

import 'package:flutter/material.dart' hide Colors;
import 'package:intl/intl.dart';
import 'package:to_do_list_flutter/common/dao/item.dart';
import 'package:to_do_list_flutter/common/style.dart';
import 'package:to_do_list_flutter/common/utils.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Function refresh;

  const ItemCard({super.key, required this.item, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(context, '/detail',
            arguments: {"id": item.id});
        dynamic res = ModalRoute.of(context)!.settings.arguments;
        if (res?['refresh'] != null) refresh();
      },
      child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          clipBehavior: Clip.hardEdge,
          color: item.deadline == null
              ? Colors.primaryLightValue
              : Colors.primaryValue,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 1)),
                  item.deadline == null
                      ? const SizedBox.shrink()
                      : const Icon(Icons.access_time_sharp,
                          color: Colors.white, size: 16)
                ],
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16, right: 30),
                  child: Text(item.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 14)),
                ),
              ),
              Text(
                "Created at ${DateFormat.yMMMMd('en_US').format(item.createTime)}",
                style: const TextStyle(
                    color: Colors.white, fontSize: 11, height: 1),
              )
            ],
          )),
    );
  }
}
