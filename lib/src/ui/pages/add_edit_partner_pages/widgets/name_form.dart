import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/profile_strings.dart';
import 'package:lustlist/src/ui/widgets/text_form.dart';

class NameForm extends StatefulWidget {
  final TextEditingController controller;

  const NameForm({
    super.key,
    required this.controller,
  });

  @override
  NameFormState createState() {
    return NameFormState();
  }
}

class NameFormState extends State<NameForm> {
  final _formKey = GlobalKey<FormState>();
  late final controller = widget.controller;
  final maxLength = 32;
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: TextForm(
        controller: widget.controller,
        validator: (value) => _nameValidate(value),
        maxLength: maxLength,
        hint: ProfileStrings.nameHint,
      )
    );
  }

  String? _nameValidate(String? value) {
    if (value == null || value == "") {
      return AlertStrings.noName;
    } else if (value.length > maxLength) {
      return AlertStrings.nameTooLong;
    }
    return null;
  }
}
