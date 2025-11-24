import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/page_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/ui/widgets/add_edit_page_base.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/category_tile.dart';
import 'package:lustlist/src/ui/widgets/add_notes_tile.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/select_partners_tile.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/ui/main.dart';
import 'package:lustlist/src/ui/controllers/add_eventdata_controller.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/data_header.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';

class AddSexEventPage extends StatefulWidget{
  final DateTime? initDay;
  const AddSexEventPage(this.initDay, {super.key});

  @override
  State<AddSexEventPage> createState() => _AddSexEventPageState();
}

class _AddSexEventPageState extends State<AddSexEventPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;
  late final DateTime _initDay = widget.initDay ?? toDate(DateTime.now());
  late final _dataController = AddEventDataController(date: _initDay);

  final repo = EventRepository(database);
  final _partnersController = SelectPartnersController();
  final _contraceptionController = AddCategoryController();
  final _practicesController = AddCategoryController();
  final _posesController = AddCategoryController();
  final _placeController = AddCategoryController();
  final _notesController = NotesTileController();

  void _onPressed() async {
    final date = _dataController.dateController.date;
    final time = _dataController.timeController.time;
    final notes = _notesController.notesController.text;
    final rating = _dataController.rating;
    final orgasmAmount = _dataController.orgasmAmount;
    final duration = _dataController.durationController.time;
    final partners = _partnersController.getSelectedPartners();
    final contraceptionOptions = _contraceptionController.getSelectedOptions();
    final practicesOptions = _practicesController.getSelectedOptions();
    final posesOptions = _posesController.getSelectedOptions();
    final placeOptions = _placeController.getSelectedOptions();

    if (partners.isEmpty){
      _partnersController.setValidation(false);
    } else {
      var id = await repo.loadEvent("sex", date, time, notes);
      repo.loadEventData(id, rating, duration, orgasmAmount, null);

      for (var p in partners.keys) {
        repo.loadEventPartner(await id, p.id, partners[p]);
      }

      var allOptionsList = [
        contraceptionOptions, practicesOptions,
        posesOptions, placeOptions
      ].expand((x) => x).toList();
      for (var o in allOptionsList) {
        repo.loadOptions(id, o.id, null);
      }

      Navigator.of(context).pop(true);
    }
  }

  @override
  void initState() {
    super.initState();
    _categoriesMapFuture = _getCategoriesList(database);
  }

  @override
  Widget build(BuildContext context) {
    return AddEditPageBase(
      onPressed: _onPressed,
      title: PageStrings.addEvent,
      body: FutureBuilder<Map<String, Category>>(
        future: _categoriesMapFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return ErrorTile();
          }

          final categoriesMap = snapshot.data!;

          return ListView(
            children: [
              BasicTile(
                surfaceColor: AppColors.addEvent.surface(context),
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 5,),
                child: AddEditEventDataColumn(
                  controller: _dataController,
                  isMstb: false
                )
              ),
              SelectPartnersTile(
                controller: _partnersController,
              ),
              AddCategoryTile(
                category: categoriesMap['contraception']!,
                controller: _contraceptionController,
                iconData: CategoryIcons.condom,
              ),
              AddCategoryTile(
                category: categoriesMap['practices']!,
                controller: _practicesController,
                iconData: CustomIcons.handLizard,
                iconSize: 22,
              ),
              AddCategoryTile(
                category: categoriesMap['poses']!,
                controller: _posesController,
                iconData: CategoryIcons.sexMove,
                iconSize: 27,
              ),
              AddCategoryTile(
                category: categoriesMap['place']!,
                controller: _placeController,
                iconData: Icons.bed,
              ),
              AddNotesTile(
                controller: _notesController,
              ),
              SizedBox(height: 20,)
            ],
          );
        },
      ),
      alertString: AlertStrings.editEvent,
      alertButton: ButtonStrings.eventReturn,
    );
  }

  Future<Map<String, Category>> _getCategoriesList(AppDatabase db) async {
    List<Category> categories = await db.allCategories;
    var categoriesMap = { for (var v in categories) v.slug: v };
    return categoriesMap;
  }
}