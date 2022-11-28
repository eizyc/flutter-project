
import 'package:flutter/material.dart' hide Colors;
import 'package:to_do_list_flutter/common/dao/option.dart';
import 'package:to_do_list_flutter/common/style.dart';



class MyFilter extends StatefulWidget {
  final void Function(dynamic) onSelected;
  final String initialValue;
  final List<Option> options;

  final Widget child;


  const MyFilter({super.key, required this.onSelected, required this.options, required this.child, required this.initialValue});

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {

  @override
  Widget build(BuildContext context) {
  String selectedValue = widget.initialValue;
  menuItems(BuildContext context) => widget.options.map((Option option)=>PopupMenuItem<String>(
        value: option.value,
        child: Text(option.label, style: TextStyle(color: selectedValue ==option.value?Colors.primaryLightValue:Colors.primaryDarkValue),)
      )).toList();


    return PopupMenuButton(
      // enabled: true,
      onSelected: (item){
        widget.onSelected(item);
        setState(() {
          selectedValue = item;
        });
      },
      itemBuilder: menuItems,
      initialValue: widget.initialValue,
      position: PopupMenuPosition.under,
      child: widget.child
      );
  }
}


