import 'package:flutter/material.dart';

class ReafySecondaryButton extends StatelessWidget {
  const ReafySecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            constraints:
                BoxConstraints(minWidth: MediaQuery.of(context).size.width / 3),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Theme.of(context).primaryColor),
                color: Colors.transparent),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16),
            )));
  }
}
