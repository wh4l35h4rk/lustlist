import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/utils/utils.dart';

class IntForm extends StatefulWidget {
  final TextEditingController controller;

  const IntForm({
    super.key,
    required this.controller,
    required this.isEnabled,
    this.hint
  });

  final bool isEnabled;
  final String? hint;

  @override
  State<IntForm> createState() => _IntFormState();
}

class _IntFormState extends State<IntForm> {
  final _formKey = GlobalKey<FormState>();
  late final controller = widget.controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        enabled: widget.isEnabled,
        validator: (value) => _valueValidate(value),
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
            hintText: widget.hint,
            hintStyle: TextStyle(
                fontSize: AppSizes.textBasic
            ),
            labelText: widget.hint
        ),
      ),
    );
  }

  String? _valueValidate(String? value) {
    if (value == null || value == "") return null;

    try {
      int numericValue = int.parse(value);
      if (numericValue >= 0 && numericValue <= maxOrgasms) {
        return null;
      } else {
        return AlertStrings.invalidValue;
      }
    } catch (e) {
      return AlertStrings.invalidValue;
    }
  }
}