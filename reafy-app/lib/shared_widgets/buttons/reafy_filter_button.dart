import 'package:flutter/material.dart';
import 'package:reafy/shared_widgets/buttons/reafy_text_button.dart';

class ReafyFilterButton extends StatelessWidget {
  const ReafyFilterButton(
      {Key? key,
      required this.text,
      required this.active,
      required this.onActivePressed,
      required this.onPressed})
      : super(key: key);

  final String text;
  final bool active;
  final VoidCallback onActivePressed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: active
            ? ReafyTextButton(
                text: text,
                onPressed: onPressed,
                color: Theme.of(context).primaryColor,
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: GestureDetector(
                    onTap: onActivePressed,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  text,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )
                              ]),
                        )))));
  }
}
