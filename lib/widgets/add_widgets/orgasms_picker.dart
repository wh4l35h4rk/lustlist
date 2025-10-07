import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import '../../database.dart';

const double _kItemExtent = 32.0;
List<int> _orgasmAmount = List.generate(12, (index) => index);

class OrgasmsAmountPicker extends StatelessWidget {
  final int amount;
  final ValueChanged<int> onChanged;

  const OrgasmsAmountPicker({
    super.key,
    required this.amount,
    required this.onChanged
  });

  void _showDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: AppColors.addEvent.pickerSurface(context),
        child: SafeArea(
            top: false,
            child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: _kItemExtent,
              scrollController: FixedExtentScrollController(initialItem: amount),
              onSelectedItemChanged: (int selectedItem) {
                onChanged(selectedItem);
              },
              children: List<Widget>.generate(_orgasmAmount.length, (int index) {
                return Center(
                    child: Text(_orgasmAmount[index].toString())
                );
              }),
            ),),
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
          onPressed: () => _showDialog(context),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            _getOrgasmsText(amount),
            style: TextStyle(
                fontSize: 14.0,
                color: AppColors.addEvent.coloredText(context)
            ),
          ),
        ),
      ),
    );
  }
}