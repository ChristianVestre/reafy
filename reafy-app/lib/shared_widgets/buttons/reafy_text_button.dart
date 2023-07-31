import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/enums.dart';

class ReafyTextButton extends StatelessWidget {
  const ReafyTextButton({
    Key? key,
    required this.text,
    this.plusIcon = false,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final bool plusIcon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: () => onPressed,
        child: plusIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.plus),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              )
            : Text(
                text,
                style: const TextStyle(color: Colors.black),
              ));
  }
}
