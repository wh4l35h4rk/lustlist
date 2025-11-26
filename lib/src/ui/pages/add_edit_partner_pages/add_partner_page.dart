import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/widgets/add_partner_data_column.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/add_partner_data_controller.dart';
import 'package:lustlist/src/ui/widgets/add_edit_page_base.dart';
import 'package:lustlist/src/ui/widgets/add_notes_tile.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';


class AddPartnerPage extends StatefulWidget{
  final DateTime? initBirthday;
  
  const AddPartnerPage({
    super.key,
    this.initBirthday,
  });

  @override
  State<AddPartnerPage> createState() => _AddPartnerPageState();
}

class _AddPartnerPageState extends State<AddPartnerPage> {
  late final DateTime _initBirthday = widget.initBirthday
      ?? toDate(DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day));
  late final _dataController = AddPartnerDataController(date: _initBirthday);

  final repo = EventRepository(database);
  final _notesController = NotesTileController();

  void _onPressed() async {
    final name = _dataController.nameController.text;
    final gender = _dataController.gender;
    final notes = _notesController.notesController.text;
    final birthday = _dataController.dateController.date;

    if (name != "") {
      await repo.loadPartner(name, gender, birthday, notes);
      Navigator.of(context).pop(true);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AddEditPageBase(
      onPressedSave: _onPressed,
      title: PageTitleStrings.addPartner,
      body: ListView(
        children: [
          BasicTile(
              surfaceColor: AppColors.addEvent.surface(context),
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 5),
              child: AddEditPartnerDataColumn(
                  controller: _dataController
              )
          ),
          AddNotesTile(
            controller: _notesController,
          ),
          SizedBox(height: 20)
        ],
      ),
      alertString: AlertStrings.editPartner,
      alertButton: ButtonStrings.partnerReturn,
    );
  }
}