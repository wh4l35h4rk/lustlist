import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';

class IntTextFieldForm extends StatefulWidget {
  final TextEditingController controller;

  const IntTextFieldForm({
    super.key,
    required this.controller,
    required this.isEnabled,
    this.hint,
    this.textSize,
    this.onChanged,
  });

  final bool isEnabled;
  final String? hint;
  final double? textSize;
  final ValueChanged? onChanged;

  @override
  State<IntTextFieldForm> createState() => _IntTextFieldFormState();
}

class _IntTextFieldFormState extends State<IntTextFieldForm> {
  final _formKey = GlobalKey<FormState>();
  late final controller = widget.controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        onChanged: widget.onChanged,
        enabled: widget.isEnabled,
        validator: (value) => _valueValidate(value),
        style: TextStyle(
          fontSize: widget.textSize ?? AppSizes.textBasic
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: AppColors.enabledBorder(context),
                    width: 1.5
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            hintText: MiscStrings.unknown,
            hintStyle: TextStyle(
              fontSize: widget.textSize != null
                ? widget.textSize! - 2
                : AppSizes.textBasic
            ),
            labelText: widget.hint,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            helperText: " ",
        ),
        controller: controller,
      ),
    );
  }

  String? _valueValidate(String? value) {
    if (value == null || value == "") return null;

    try {
      int numericValue = int.parse(value);
      if (numericValue >= 0) {
        return null;
      } else {
        return AlertStrings.invalidValue;
      }
    } catch (e) {
      return AlertStrings.invalidValue;
    }
  }
}