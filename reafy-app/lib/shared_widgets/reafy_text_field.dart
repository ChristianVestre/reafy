import 'package:flutter/material.dart';
import 'package:reafy/theme/colors.dart';

class ReafyTextField extends StatelessWidget {
  const ReafyTextField(
      {Key? key, this.controller, this.onChanged, this.hintText})
      : super(key: key);

  final TextEditingController? controller;
  final ValueSetter<String>? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).borderColor),
            filled: true,
            fillColor: Theme.of(context).lightGray,
            focusColor: Theme.of(context).borderColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
            border: const OutlineInputBorder(
                gapPadding: 0, borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.all(8),
            isDense: true),
        cursorColor: Theme.of(context).borderColor,
        style: Theme.of(context).textTheme.bodyLarge,
        controller: controller,
        onChanged: onChanged);
  }
}
