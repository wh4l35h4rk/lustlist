import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';

const double _kItemExtent = 32.0;
List<int> _orgasmAmount = List.generate(12, (index) => index);

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
        color: AppColors.addEvent.pickerSurface(context),
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
              bottom: BorderSide(color: AppColors.addEvent.border(context))
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