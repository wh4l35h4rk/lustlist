import 'package:flutter/material.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/widgets/add_partner_data_column.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/edit_partner_data_controller.dart';
import 'package:lustlist/src/ui/widgets/add_edit_page_base.dart';
import 'package:lustlist/src/ui/widgets/add_notes_tile.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';


class EditPartnerPage extends StatefulWidget{
  final Partner partner;

  const EditPartnerPage({
    super.key,
    required this.partner,
  });

  @override
  State<EditPartnerPage> createState() => _EditPartnerPageState();
}

class _EditPartnerPageState extends State<EditPartnerPage> {
  final repo = EventRepository(database);
  late final partner = widget.partner;

  late final _dataController = EditPartnerDataController(
    name: partner.name,
    isBirthdayUnknown: partner.birthday == null,
    birthday: partner.birthday,
    gender: partner.gender
  );
  late final _notesController = NotesTileController(notes: partner.notes);


  void _onPressed() async {
    final name = _dataController.nameController.text;
    final gender = _dataController.gender;
    final birthday = _dataController.dateController.date;
    final notes = _notesController.notesController.text;

    if (name != "") {
      await repo.updatePartner(partner.id, name, gender, birthday, notes);

      Navigator.of(context).pop(true);
      eventsUpdated.notifyUpdate();
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
      title: PageTitleStrings.editPartner,
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