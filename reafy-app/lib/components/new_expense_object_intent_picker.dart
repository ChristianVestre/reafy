import 'package:flutter/cupertino.dart';

import '../views/new_expense_object_view.dart';

const double _kItemExtent = 32.0;

class NewExpenseObjectIntentPicker extends StatefulWidget {
  const NewExpenseObjectIntentPicker(
      {Key? key,
      required this.data,
      required this.selectedIntentItem,
      required this.intentItems})
      : super(key: key);

  final NewExpenseObjectData data;
  final ValueNotifier<int> selectedIntentItem;
  final List<String> intentItems;

  @override
  State<NewExpenseObjectIntentPicker> createState() =>
      _NewExpenseObjectIntentPickerState();
}

class _NewExpenseObjectIntentPickerState
    extends State<NewExpenseObjectIntentPicker> {
  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 20,
        ),
        child: Center(
          child: Column(children: [
            const Text(
              "Expense intent",
              style: TextStyle(fontSize: 24),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Text(
                'Select intent: ',
                style: TextStyle(fontSize: 20),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                // Display a CupertinoPicker with list of fruits.
                onPressed: () => _showDialog(
                  CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: _kItemExtent,
                    // This sets the initial item.
                    scrollController: FixedExtentScrollController(
                      initialItem: widget.selectedIntentItem.value,
                    ),
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        widget.selectedIntentItem.value = selectedItem;
                      });
                      widget.data.intent =
                          widget.intentItems[widget.selectedIntentItem.value];
                    },
                    children: List<Widget>.generate(widget.intentItems.length,
                        (int index) {
                      return Center(child: Text(widget.intentItems[index]));
                    }),
                  ),
                ),
                // This displays the selected fruit name.
                child: Text(
                  widget.intentItems[widget.selectedIntentItem.value],
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ])
          ]),
        ));
  }
}
