import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/enums/test_status.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/ui/widgets/add_edit_page_base.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/category_tile.dart';
import 'package:lustlist/src/ui/widgets/add_notes_tile.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/sti_tile.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/ui/controllers/edit_meddata_controller.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/med_data_header.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/core/widgets/loading_scaffold.dart';
import 'package:lustlist/src/core/utils/utils.dart';


class EditMedEventPage extends StatefulWidget{
  final CalendarEvent event;

  const EditMedEventPage({
    super.key,
    required this.event,
  });

  @override
  State<EditMedEventPage> createState() => _EditMedEventPageState();
}

class _EditMedEventPageState extends State<EditMedEventPage> {
  final repo = EventRepository(database);
  late Future<Map<String, Category>> _categoriesMapFuture;
  late final event = widget.event;
  bool _isLoading = true;

  late final _notesController = NotesTileController(notes: event.event.notes);

  EditMedEventDataController? _dataController;
  AddCategoryController? _stiController;
  AddCategoryController? _obgynController;

  void _onPressed() async {
    final date = _dataController!.dateController.date ?? toDate(kToday);
    final time = _dataController!.timeController.time;
    final notes = _notesController.notesController.text;
    final stiOptions = _stiController!.getSelectedOptions();
    final stiStatuses = _stiController!.statusMap;
    final obgynOptions = _obgynController!.getSelectedOptions();

    repo.updateEvent(event.event.id, date, time, notes);
    database.deleteEventOptions(event.event.id);

    for (var o in obgynOptions) {
      repo.loadOptions(event.event.id, o.id, null);
    }
    for (var o in stiOptions) {
      repo.loadOptions(event.event.id, o.id, stiStatuses[o]);
    }

    Navigator.of(context).pop(true);
    eventsUpdated.notifyUpdate();
  }

  @override
  void initState() {
    _categoriesMapFuture = _getCategoriesList(database);
    super.initState();
    _initControllers(database);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return LoadingScaffold(hasBackButton: true);

    return AddEditPageBase(
      onPressedSave: _onPressed,
      title: PageTitleStrings.editEvent,
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
                  valueListenable: _dataController!.stiController,
                  builder: (context, isSti, child) {
                    return isSti ? AddStiTile(
                      category: categoriesMap['sti']!,
                      controller: _stiController!,
                      iconData: CustomIcons.viruses,
                    ) : const SizedBox.shrink();
                  }
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: _dataController!.obgynController,
                  builder: (context, isObgyn, child) {
                    return isObgyn ? AddCategoryTile(
                      category: categoriesMap['obgyn']!,
                      controller: _obgynController!,
                      iconData: CategoryIcons.uterus,
                      iconSize: 29,
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

  Future<void> _initControllers(AppDatabase db) async {
    final obgynOptions = await repo.getOptionsList(event.event.id, "obgyn");
    final stiOptions = await repo.getOptionsList(event.event.id, "sti");

    Map<EOption, TestStatus> statusMap = {};
    for (var o in stiOptions) {
      TestStatus? result = await db.getTestResult(event.event.id, o.id);
      statusMap[o] = result ?? TestStatus.waiting;
    }

    setState(() {
      _dataController = EditMedEventDataController(
          date: event.event.date,
          time: event.event.time,
          isSti: stiOptions.isNotEmpty,
          isObgyn: obgynOptions.isNotEmpty
      );
      _obgynController = AddCategoryController(
        selectedOptionsList: obgynOptions,
      );
      _stiController = AddCategoryController(
        selectedOptionsList: stiOptions,
        statusMap: statusMap
      );
      _isLoading = false;
    });
  }
}