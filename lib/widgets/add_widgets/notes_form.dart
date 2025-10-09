import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';


class NotesForm extends StatefulWidget {
  final TextEditingController controller;

  const NotesForm({
    super.key,
    required this.controller
  });

  @override
  State<NotesForm> createState() => _NotesFormState();
}

class _NotesFormState extends State<NotesForm> {
  TextEditingController get controller => widget.controller;
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
      validator: (value) {
        if (value != null && value.length > 500) {
          return 'Your note extends maximal length!';
        }
        return null;
      },
      style: TextStyle(fontSize: 14),
      maxLength: 500,
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
        hintText: 'Write some notes!',
      ),
    );
  }
}