import 'package:flutter/material.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/buttons/secondary_button.dart';

class ReafyNavFooter extends StatelessWidget {
  const ReafyNavFooter(
      {Key? key,
      required this.backText,
      required this.forwardText,
      required this.backOnPressed,
      required this.forwardOnPressed})
      : super(key: key);

  final String backText;
  final String forwardText;
  final VoidCallback backOnPressed;
  final VoidCallback forwardOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ReafySecondaryButton(text: backText, onPressed: backOnPressed),
      ReafyPrimaryButton(text: forwardText, onPressed: forwardOnPressed)
    ]);
  }
}
