import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _kItemExtent = 32.0;
List<int> _orgasmAmount = List.generate(12, (index) => index);

void main() => runApp(const CupertinoPickerApp());

class CupertinoPickerApp extends StatelessWidget {
  const CupertinoPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: OrgasmsAmountPicker(),
    );
  }
}

class OrgasmsAmountPicker extends StatefulWidget {
  const OrgasmsAmountPicker({super.key});

  @override
  State<OrgasmsAmountPicker> createState() => _OrgasmsAmountPickerState();
}

class _OrgasmsAmountPickerState extends State<OrgasmsAmountPicker> {
  int _selectedAmount = 0;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  String _getOrgasmsText(int orgasmsAmount) {
    final String amountString = orgasmsAmount.toString();
    final String orgasmsString;
    if (orgasmsAmount == 1) {
      orgasmsString = "orgasm";
    } else {
      orgasmsString = "orgasms";
    }
    return "$amountString $orgasmsString";
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).colorScheme.primary)
          )
      ),
      child: SizedBox(
        height: 24,
        child: CupertinoButton(
          onPressed: () => _showDialog(
            CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: _kItemExtent,
              scrollController: FixedExtentScrollController(initialItem: _selectedAmount),
              onSelectedItemChanged: (int selectedItem) {
                setState(() {
                  _selectedAmount = selectedItem;
                });
              },
              children: List<Widget>.generate(_orgasmAmount.length, (int index) {
                return Center(child: Text(_orgasmAmount[index].toString()));
              }),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            _getOrgasmsText(_selectedAmount),
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}