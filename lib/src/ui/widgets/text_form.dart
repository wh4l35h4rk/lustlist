import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';


class TextForm extends StatefulWidget {
  final TextEditingController controller;
  final Function validator;
  final int? maxLength;
  final String? hint;

  const TextForm({
    super.key,
    required this.controller,
    required this.validator,
    required this.maxLength,
    this.hint,
  });

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  TextEditingController get controller => widget.controller;
  int? get maxLength => widget.maxLength;

  late VoidCallback _controllerListener;

  @override
  void dispose() {
    controller.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  void initState() {
    _controllerListener = () {
      if (mounted) {
        setState(() {});
      }
    };

    controller.addListener(_controllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => widget.validator(value),
      style: TextStyle(fontSize: AppSizes.textBasic),
      maxLength: maxLength,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
        return Text(
          "$currentLength/$maxLength",
          style: TextStyle(
            color: AppColors.addEvent.coloredText(context)
          ),
        );
      },
      textAlign: TextAlign.justify,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.addEvent.coloredText(context),
            width: 1.5
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.addEvent.border(context)),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.hint
      ),
    );
  }
}