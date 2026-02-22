import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/ui/widgets/add_edit_page_base.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/category_tile.dart';
import 'package:lustlist/src/ui/widgets/add_notes_tile.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/ui/controllers/add_eventdata_controller.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/data_header.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';


class AddMstbEventPage extends StatefulWidget{
  final DateTime? initDay;

  const AddMstbEventPage(this.initDay, {super.key});

  @override
  State<AddMstbEventPage> createState() => _AddMstbEventPageState();
}

class _AddMstbEventPageState extends State<AddMstbEventPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;
  late final DateTime _initDay = widget.initDay ?? DateFormatter.dateOnly(DateTime.now());
  late final _dataController = AddEventDataController(date: _initDay);

  final repo = EventRepository(database);
  final _practicesController = AddCategoryController();
  final _placeController = AddCategoryController();
  final _complicaciesController = AddCategoryController();
  final _notesController = NotesTileController();

  void _onPressed() async {                  
    final date = _dataController.dateController.date ?? DateFormatter.dateOnly(kToday);
    final time = _dataController.timeController.time;
    final notes = _notesController.notesController.text;
    final rating = _dataController.rating;
    final orgasmAmount = _dataController.orgasmAmount;
    final duration = EventDuration.explicit(
        0,
        _dataController.durationController.time.hour,
        _dataController.durationController.time.minute
    );
    final didWatchPorn = _dataController.pornController.value;
    final didUseToys = _dataController.toysController.value;
    final practicesOptions = _practicesController.getSelectedOptions();
    final placeOptions = _placeController.getSelectedOptions();
    final complicaciesOptions = _complicaciesController.getSelectedOptions();
    
    var id = await repo.loadEvent("masturbation", date, time, notes);
    repo.loadEventData(id, rating, duration, orgasmAmount, didWatchPorn, didUseToys);
    
    var allOptionsList = [practicesOptions, placeOptions, complicaciesOptions].expand((x) => x).toList();
    for (var o in allOptionsList) {
      repo.loadOptions(id, o.id, null);
    }
    
    Navigator.of(context).pop();
    eventsUpdated.notifyUpdate();
  }

  @override
  void initState() {
    super.initState();
    _categoriesMapFuture = _getCategoriesList(database);
  }

  @override
  Widget build(BuildContext context) {
    return AddEditPageBase(
      onPressedSave: _onPressed,
      title: PageTitleStrings.addEvent,
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
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 5),
                child: AddEditEventDataColumn(
                  controller: _dataController,
                  isMstb: true,
                )
              ),
              AddCategoryTile(
                category: categoriesMap['solo practices']!,
                controller: _practicesController,
                iconData: CustomIcons.handLizard,
                iconSize: 22,
              ),
              AddCategoryTile(
                category: categoriesMap['place']!,
                controller: _placeController,
                iconData: Icons.bed,
              ),
              AddCategoryTile(
                category: categoriesMap['complicacies']!,
                controller: _complicaciesController,
                iconData: Icons.error,
              ),
              AddNotesTile(
                controller: _notesController,
              ),
              SizedBox(height: 20)
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