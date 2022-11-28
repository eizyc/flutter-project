import 'package:flutter/material.dart' hide Colors;
import 'package:to_do_list_flutter/common/style.dart';
import 'package:intl/intl.dart';

class MyInput extends StatefulWidget {
  final Type type;
  final String? placeholder;
  final bool dark;
  final bool bolder;
  final bool expanded;
  final Widget? icon;
  final void Function(dynamic)? onChanged;
  const MyInput(
      {super.key,
      this.onChanged,
      this.placeholder = "",
      this.type = Type.normal,
      this.dark = true,
      this.bolder = false,
      this.expanded = false,
      this.icon});

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  var input = TextEditingController();
  bool visible = true;
  double borderWidth = 1;
  double opacity = 0.5;
  Widget icon = const SizedBox.shrink();
  bool readOnly = false;
  Color iconColor = const Color(0xFF949494);
  Function onTapHandler = () {};
  datePickerFun() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(
          pickedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
        input.text = formattedDate; //set output date to TextField value.
      });
      widget.onChanged!(pickedDate);
    }
  }

  imgPickerFun() async {}

  @override
  void initState() {
    super.initState();
    setState(() {
      borderWidth = widget.bolder ? 2 : 1;
      opacity = widget.bolder ? 1 : 0.5;
      if (!widget.dark) iconColor = Colors.white.withOpacity(opacity);
      if (widget.type == Type.password) {
        visible = false;
        icon = IconButton(
            padding: const EdgeInsets.all(0),
            color: Colors.primaryValue,
            constraints: const BoxConstraints(),
            icon: Icon(
                visible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: iconColor,
                size: 24),
            onPressed: () {
              setState(() {
                visible = !visible;
              });
            });
      } else if (widget.type == Type.calendar) {
        readOnly = true;
        onTapHandler = datePickerFun;
        icon = IconButton(
            padding: const EdgeInsets.all(0),
            constraints: const BoxConstraints(),
            icon:
                Icon(Icons.calendar_today_outlined, color: iconColor, size: 24),
            onPressed: datePickerFun);
      } else if (widget.type == Type.image) {
        readOnly = true;
        onTapHandler = imgPickerFun;
        icon = IconButton(
            padding: const EdgeInsets.all(0),
            color: iconColor,
            constraints: const BoxConstraints(),
            icon: Icon(Icons.image_outlined, color: iconColor, size: 24),
            onPressed: () {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.expanded ? 1 : 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 11.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: widget.dark
                  ? Colors.primaryDarkValue.withOpacity(opacity)
                  : Colors.white.withOpacity(opacity),
              width: borderWidth),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextField(
                  maxLines: widget.expanded ? 100000 : 1,
                  controller: input,
                  readOnly: readOnly,
                  obscureText: !visible,
                  obscuringCharacter: "*",
                  onChanged: widget.onChanged,
                  autofocus: false,
                  onTap: () => onTapHandler(),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(0),
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(
                        color: widget.dark
                            ? Colors.primaryDarkValue.withOpacity(opacity)
                            : Colors.white),
                    isDense: true,
                  ),
                  style: TextStyle(
                      fontSize: 16.0,
                      height: 1.7,
                      color: widget.dark
                          ? Colors.primaryDarkValue.withOpacity(opacity)
                          : Colors.white)),
            ),
            icon
          ],
        ),
      ),
    );
  }
}

enum Type { password, normal, calendar, image }
