import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/ui/widgets/int_text_field_form.dart';

class AgeTextField extends StatefulWidget {
  final TextEditingController controller;

  const AgeTextField({
    super.key,
    required this.controller,
  });

  @override
  State<AgeTextField> createState() => _AgeTextFieldState();
}

class _AgeTextFieldState extends State<AgeTextField> {
  String get age {
    String text = widget.controller.text;
    if (text == "" || !_isValid(text)) {
      return MiscStrings.unknown;
    } else {
      return StringFormatter.age(text);
    }
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
        child: Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: CupertinoButton(
            onPressed: () => _showDialog(context),
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              age,
              style: TextStyle(
                fontSize: AppSizes.textBasic,
                color: AppColors.addEvent.coloredText(context)
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    if (!_isValid(widget.controller.text)) {
      widget.controller.text = "";
    }
    return showModalBottomSheet(
        backgroundColor: AppColors.addEvent.pickerSurface(context),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: IntTextFieldForm(
                      controller: widget.controller,
                      hint: DataStrings.age,
                      isEnabled: true,
                      textSize: AppSizes.titleLarge,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,)
            ],
          );
        }
    );
  }

  bool _isValid(String? value) {
    if (value == null || value == "") return true;

    try {
      int numericValue = int.parse(value);
      if (numericValue >= 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
