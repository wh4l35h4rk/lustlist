import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';


class AddEditPageBase extends StatefulWidget{
  final Function onPressedSave;
  final Widget body;
  final String title;

  final String alertString;
  final String alertButton;

  const AddEditPageBase({
    super.key,
    required this.onPressedSave,
    required this.title,
    required this.body,
    required this.alertString,
    required this.alertButton
  });

  @override
  State<AddEditPageBase> createState() => _AddEditPageBaseState();
}

class _AddEditPageBaseState extends State<AddEditPageBase> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: MainAppBar(
            title: widget.title,
            backButton: IconButton(
                onPressed: () => _showPopUp(context, null),
                icon: Icon(AppIconData.backButton, size: context.sizes.iconBasic),
                color: context.theme.mainColors.surface
            ),
            editButton: IconButton(
                onPressed: () async => widget.onPressedSave(),
                icon: Icon(AppIconData.selected, size: context.sizes.iconBasic),
                color: context.theme.mainColors.surface
            ),
          ),
          body: widget.body,
          bottomNavigationBar: MainBottomNavigationBar(
            context: context,
            currentIndex: HomeNavigationController.pageIndex.value,
            onTap: (index) => _showPopUp(context, index),
          )
      ),
    );
  }

  void _showPopUp(BuildContext context, int? index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap:() {
            Navigator.of(context).pop();
          },
          child: AlertDialog(
            content: Text(
              widget.alertString,
              style: TextStyle(fontSize: context.sizes.alertBody),
              textAlign: TextAlign.justify,
            ),
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  widget.alertButton,
                  style: TextStyle(fontSize: context.sizes.alertButtonText)
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                onPressed: () {
                  if (index != null) {
                    HomeNavigationController.pageIndex.value = index;
                    Navigator.popUntil(context, (route) => route.isFirst);
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
                color: context.theme.appBarColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  ButtonStrings.leave,
                  style: TextStyle(
                    fontSize: context.sizes.alertButtonText,
                    color: context.theme.appBarColors.text
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}