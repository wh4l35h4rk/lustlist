import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/test_status.dart';
import 'package:lustlist/pages/add_edit_event_base.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/notes_tile.dart';
import 'package:lustlist/widgets/add_widgets/sti_tile.dart';
import '../../calendar_event.dart';
import '../../controllers/add_category_controller.dart';
import '../../controllers/edit_meddata_controller.dart';
import '../../repository.dart';
import '../../main.dart';
import '../../widgets/add_widgets/med_data_header.dart';
import '../../widgets/basic_tile.dart';


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
    final date = _dataController!.dateController.date;
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
  }

  @override
  void initState() {
    _categoriesMapFuture = _getCategoriesList(database);
    super.initState();
    _initControllers(database);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return AddEditEventPageBase(
      _onPressed,
      "Edit event",
      FutureBuilder<Map<String, Category>>(
        future: _categoriesMapFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(
                child: Text(
                  "Error loading data.",
                  style: TextStyle(
                    color: AppColors.addEvent.text(context),
                  ),
                )
            );
          }

          final categoriesMap = snapshot.data!;

          return ListView(
            children: [
              BasicTile(
                  surfaceColor: AppColors.addEvent.surface(context),
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 5,),
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
              SizedBox(height: 20,)
            ],
          );
        },
      ),
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