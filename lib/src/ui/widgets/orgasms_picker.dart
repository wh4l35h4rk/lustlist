import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';

const double _kItemExtent = 32.0;
List<int> _orgasmAmount = List.generate(12, (index) => index);


class OrgasmsAmountPicker extends StatelessWidget {
  final int? amount;
  final ValueChanged<int?> onChanged;

  const OrgasmsAmountPicker({
    super.key,
    required this.amount,
    required this.onChanged
  });

  void _showDialog(BuildContext context) {
    var children = List<Widget>.generate(_orgasmAmount.length, (int index) {
      return Center(
          child: Text(_orgasmAmount[index].toString())
      );
    });
    children.insert(0, Text(MiscStrings.unknown));

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
              scrollController: FixedExtentScrollController(initialItem: amount != null ? amount! + 1 : 0),
              onSelectedItemChanged: (int selectedItem) {
                if (selectedItem == 0) {
                  onChanged(null);
                } else {
                  onChanged(selectedItem - 1);
                }
              },
              children: children
            ),),
      ),
    );
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
            StringFormatter.orgasmsAmount(amount),
            style: TextStyle(
                fontSize: AppSizes.textBasic,
                color: AppColors.addEvent.coloredText(context)
            ),
          ),
        ),
      ),
    );
  }
}