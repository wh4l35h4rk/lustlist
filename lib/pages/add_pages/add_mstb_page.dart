import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/pages/add_event_page_base.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/notes_tile.dart';
import '../../load2db_methods.dart';
import '../../main.dart';
import '../../widgets/add_widgets/data_header.dart';
import '../../widgets/basic_tile.dart';

class AddMstbEventPage extends StatefulWidget{
  final DateTime? initDay;

  const AddMstbEventPage(this.initDay, {super.key});

  @override
  State<AddMstbEventPage> createState() => _AddMstbEventPageState();
}

class _AddMstbEventPageState extends State<AddMstbEventPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;
  late final DateTime? _initDay = widget.initDay;

  final _dataController = AddEventDataController();
  final _practicesController = AddCategoryController();
  final _placeController = AddCategoryController();
  final _notesController = NotesTileController();

  void _onPressed() async {                  
    final date = _dataController.dateController.date;
    final time = _dataController.timeController.time;
    final notes = _notesController.notesController.text;
    final rating = _dataController.rating;
    final orgasmAmount = _dataController.orgasmAmount;
    final duration = _dataController.durationController.time;
    final didWatchPorn = _dataController.pornController.value;
    final practicesOptions = _practicesController.getSelectedOptions();
    final placeOptions = _placeController.getSelectedOptions();
    
    var id = loadEvent(database, "masturbation", date, time, notes);
    loadEventData(database, id, rating, duration, orgasmAmount, didWatchPorn);
    
    var allOptionsList = [practicesOptions, placeOptions].expand((x) => x).toList();
    for (var o in allOptionsList) {
      loadOptions(database, id, o.id, null);
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
                child: AddEventDataColumn(
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