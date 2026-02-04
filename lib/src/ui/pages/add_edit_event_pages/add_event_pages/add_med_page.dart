import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/ui/widgets/add_edit_page_base.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/category_tile.dart';
import 'package:lustlist/src/ui/widgets/add_notes_tile.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/sti_tile.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/med_data_header.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';


class AddMedEventPage extends StatefulWidget{
  final DateTime? initDay;
  const AddMedEventPage(this.initDay, {super.key});

  @override
  State<AddMedEventPage> createState() => _AddMedEventPageState();
}

class _AddMedEventPageState extends State<AddMedEventPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;
  late final DateTime _initDay = widget.initDay ?? DateFormatter.dateOnly(DateTime.now());
  late final _dataController = AddMedEventDataController(date: _initDay);

  final repo = EventRepository(database);
  final _stiController = AddCategoryController();
  final _obgynController = AddCategoryController();
  final _notesController = NotesTileController();

  void _onPressed() async {
    final date = _dataController.dateController.date ?? DateFormatter.dateOnly(kToday);
    final time = _dataController.timeController.time;
    final notes = _notesController.notesController.text;
    final stiOptions = _stiController.getSelectedOptions();
    final stiStatuses = _stiController.statusMap;
    final obgynOptions = _obgynController.getSelectedOptions();

    var id = await repo.loadEvent("medical", date, time, notes);
    for (var o in obgynOptions) {
      repo.loadOptions(id, o.id, null);
    }
    for (var o in stiOptions) {
      repo.loadOptions(id, o.id, stiStatuses[o]);
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
                  child: AddMedEventDataColumn(
                    controller: _dataController
                  )
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: _dataController.stiController,
                  builder: (context, isSti, child) {
                    return isSti ? AddStiTile(
                      category: categoriesMap['sti']!,
                      controller: _stiController,
                      iconData: CustomIcons.viruses,
                    ) : const SizedBox.shrink();
                  }
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _dataController.obgynController,
                builder: (context, isObgyn, child) {
                  return isObgyn ? AddCategoryTile(
                    category: categoriesMap['obgyn']!,
                    controller: _obgynController,
                    iconData: CategoryIcons.uterus,
                    iconSize: AppSizes.iconObgyn,
                  ) : const SizedBox.shrink();
                }
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