import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/example_utils.dart';
import 'package:lustlist/pages/add_event_page_base.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/notes_tile.dart';
import 'package:lustlist/widgets/add_widgets/sti_tile.dart';
import '../../load2db_methods.dart';
import '../../main.dart';
import '../../widgets/add_widgets/med_data_header.dart';
import '../../widgets/basic_tile.dart';

class AddMedEventPage extends StatefulWidget{
  final DateTime? initDay;
  const AddMedEventPage(this.initDay, {super.key});

  @override
  State<AddMedEventPage> createState() => _AddMedEventPageState();
}

class _AddMedEventPageState extends State<AddMedEventPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;
  late final DateTime _initDay = widget.initDay ?? toDate(DateTime.now());
  late final _dataController = AddMedEventDataController(date: _initDay);

  final _stiController = AddCategoryController();
  final _obgynController = AddCategoryController();
  final _notesController = NotesTileController();

  void _onPressed() async {
    final date = _dataController.dateController.date;
    final time = _dataController.timeController.time;
    final notes = _notesController.notesController.text;
    final stiOptions = _stiController.getSelectedOptions();
    final stiStatuses = _stiController.statusMap;
    final obgynOptions = _obgynController.getSelectedOptions();

    print(stiStatuses);

    var id = loadEvent(database, "medical", date, time, notes);

    for (var o in obgynOptions) {
      loadOptions(database, id, o.id, null);
    }
    for (var o in stiOptions) {
      loadOptions(database, id, o.id, stiStatuses[o]);
    }

    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    super.initState();
    _categoriesMapFuture = _getCategoriesList(database);
  }

  @override
  Widget build(BuildContext context) {
    return AddEventPageBase(
      _onPressed,
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
}