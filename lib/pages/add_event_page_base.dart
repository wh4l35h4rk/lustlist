import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';

class AddEventPageBase extends StatefulWidget{
  final Function onPressed;
  final Widget body;

  const AddEventPageBase(
    this.onPressed,
    this.body,
    {super.key}
  );

  @override
  State<AddEventPageBase> createState() => _AddEventPageBaseState();
}

class _AddEventPageBaseState extends State<AddEventPageBase> {

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
            title: "Add new event",
            backButton: IconButton(
                onPressed: () => _showPopUp(context),
                icon: Icon(Icons.arrow_back_ios),
                color: AppColors.surface(context)
            ),
            editButton: IconButton(
                onPressed: () async => widget.onPressed(),
                icon: Icon(Icons.check),
                color: AppColors.surface(context)
            ),
          ),
          body: widget.body,
          bottomNavigationBar: MainBottomNavigationBar()
      ),
    );
  }

  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap:() {
            Navigator.of(context).pop();
          },
          child: AlertDialog(
            content: Text(
              "Are you sure you want to leave this menu? Your event won't be saved.",
              style: TextStyle(fontSize: 15, ),
              textAlign: TextAlign.justify,
            ),
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text("Return to event"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                color: AppColors.appBar.surface(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Leave",
                  style: TextStyle(color: AppColors.appBar.text(context)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}