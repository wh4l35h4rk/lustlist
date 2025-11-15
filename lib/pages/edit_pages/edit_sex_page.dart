import 'package:flutter/material.dart';
import 'package:lustlist/calendar_event.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/pages/add_edit_event_base.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/notes_tile.dart';
import 'package:lustlist/widgets/add_widgets/select_partners_tile.dart';
import '../../load2db_methods.dart';
import '../../main.dart';
import '../../widgets/add_widgets/data_header.dart';
import '../../widgets/basic_tile.dart';
import '../../edit_eventdata_controller.dart';

class EditSexEventPage extends StatefulWidget{
  final CalendarEvent event;
  
  const EditSexEventPage({
    super.key,
    required this.event,
  });

  @override
  State<EditSexEventPage> createState() => _EditSexEventPageState();
}

class _EditSexEventPageState extends State<EditSexEventPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;
  late final event = widget.event;
  bool _isLoading = true;

  late final _dataController = EditEventDataController(
    date: event.event.date,
    time: event.event.time,
    duration: event.data?.duration,
    didWatchPorn: event.data?.didWatchPorn,
    rating: event.data?.rating,
    orgasmAmount: event.data?.userOrgasms,
  );

  late final _partnersController = SelectPartnersController(
    selectedPartnersMap: event.partnersMap ?? {}
  );

  late final _notesController = NotesTileController(notes: event.event.notes);

  AddCategoryController? _contraceptionController;
  AddCategoryController? _practicesController;
  AddCategoryController? _posesController;
  AddCategoryController? _placeController;

  void _onPressed() async {
    final date = _dataController.dateController.date;
    final time = _dataController.timeController.time;
    final notes = _notesController.notesController.text;
    final rating = _dataController.rating;
    final orgasmAmount = _dataController.orgasmAmount;
    final duration = _dataController.durationController.time;
    final partners = _partnersController.getSelectedPartners();
    final contraceptionOptions = _contraceptionController!.getSelectedOptions();
    final practicesOptions = _practicesController!.getSelectedOptions();
    final posesOptions = _posesController!.getSelectedOptions();
    final placeOptions = _placeController!.getSelectedOptions();

    if (partners.isEmpty){
      _partnersController.setValidation(false);
    } else {
      updateEvent(database, event.event.id, date, time, notes);
      updateEventData(database, event.event.id, rating!, duration, orgasmAmount!, null);
      deleteEventPartners(database, event.event.id);
      deleteEventOptions(database, event.event.id);

      for (var p in partners.keys) {
        loadEventPartner(database, event.event.id, p.id, partners[p]);
      }

      var allOptionsList = [
        contraceptionOptions, practicesOptions,
        posesOptions, placeOptions
      ].expand((x) => x).toList();
      for (var o in allOptionsList) {
        loadOptions(database, event.event.id, o.id, null);
      }

      Navigator.of(context).pop(true);
    }
  }

  @override
  void initState() {
    super.initState();
    _initControllers();
    _categoriesMapFuture = _getCategoriesList(database);
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
                controller: _contraceptionController!,
                iconData: CategoryIcons.condom,
              ),
              AddCategoryTile(
                category: categoriesMap['practices']!,
                controller: _practicesController!,
                iconData: CustomIcons.handLizard,
                iconSize: 22,
              ),
              AddCategoryTile(
                category: categoriesMap['poses']!,
                controller: _posesController!,
                iconData: CategoryIcons.sexMove,
                iconSize: 27,
              ),
              AddCategoryTile(
                category: categoriesMap['place']!,
                controller: _placeController!,
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

  Future<void> _initControllers() async {
    final contraceptionOptions = await _getOptionsList(database, "contraception");
    final practicesOptions = await _getOptionsList(database, "practices");
    final posesOptions = await _getOptionsList(database, "poses");
    final placeOptions = await _getOptionsList(database, "place");

    setState(() {
      _contraceptionController = AddCategoryController(
        selectedOptionsList: contraceptionOptions,
      );
      _practicesController = AddCategoryController(
        selectedOptionsList: practicesOptions,
      );
      _posesController = AddCategoryController(
        selectedOptionsList: posesOptions,
      );
      _placeController = AddCategoryController(
        selectedOptionsList: placeOptions,
      );
      _isLoading = false;
    });
  }

  Future<List<EOption>> _getOptionsList(AppDatabase db, String categorySlug) async {
    int categoryId = await db.getCategoryIdBySlug(categorySlug);
    List<EOption> options = await db.getEventOptionsByCategory(event.event.id, categoryId);
    return options;
  }
}