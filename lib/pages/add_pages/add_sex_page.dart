import 'package:flutter/material.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import '../../widgets/add_widgets/sex_event_header.dart';

class AddSexEventPage extends StatefulWidget{
  const AddSexEventPage({super.key});

  @override
  State<AddSexEventPage> createState() => _AddSexEventPageState();
}

class _AddSexEventPageState extends State<AddSexEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          title: "Add new event",
          backButton: IconButton(
            onPressed: () => _showPopUp(context),
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).colorScheme.surface,
          ),
          editButton: IconButton(
            onPressed: () {
              //TODO: save event
            },
            icon: Icon(Icons.check),
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        body: ListView(children: [
          AddSexEventData()
        ],),
        bottomNavigationBar: MainBottomNavigationBar()
    );
  }

  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you sure you want to leave this menu? Your event won't be saved.",
            style: TextStyle(fontSize: 15, ),
            textAlign: TextAlign.justify,
          ),
          actions: [
            MaterialButton(
              child: const Text("Leave"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            ),
            MaterialButton(
              child: const Text("Return"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}