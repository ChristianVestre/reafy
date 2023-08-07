import 'package:flutter/material.dart';

import '../../models/enums.dart';

class ReafyTextButton extends StatelessWidget {
  const ReafyTextButton({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.plusIcon = false,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final String text;
  final bool plusIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.transparent;
                }
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return Colors.transparent;
                }
                return null;
              },
            )),
        child: plusIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                    size: 32,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w400,
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge!.fontSize),
                  )
                ],
              )
            : Text(
                text,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w400,
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
              ));
  }
}
