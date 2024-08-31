import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String>? items;
  final String? hint;
  final Color? buttonColor;
  final Function(String value)? getValue;
  final VoidCallback? callback;

  CustomDropDown({
    Key? key,
    this.items,
    this.hint,
    this.buttonColor,
    this.getValue,
    this.callback,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          widget.hint ?? 'Select Item',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B5C98),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        items: (widget.items ?? []).map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF0B5C98),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )).toList(),
        value: selectedValue,
        onChanged: (String? value) {
          if (value != null) {
            if (widget.getValue != null) {
              widget.getValue!(value);
            }
            setState(() {
              selectedValue = value;
            });
            if (widget.callback != null) {
              widget.callback!();
            }
          }
        },
        buttonStyleData: ButtonStyleData(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: Color(0xFF0B5C98),
              width: 2,
            ),
            color: widget.buttonColor ?? Colors.transparent,
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            size: 25,
          ),
          iconSize: 14,
          iconEnabledColor: Color(0xFF0B5C98),
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.white,
          ),
          offset: const Offset(0, -4),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
          ),
        ),
      ),
    );
  }
}
