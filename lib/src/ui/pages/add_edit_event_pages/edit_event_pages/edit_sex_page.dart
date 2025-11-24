import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/ui/widgets/add_edit_page_base.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/category_tile.dart';
import 'package:lustlist/src/ui/widgets/add_notes_tile.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/select_partners_tile.dart';
import 'package:lustlist/src/core/widgets/loading_scaffold.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/ui/main.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/data_header.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/ui/controllers/edit_eventdata_controller.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';


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
  final repo = EventRepository(database);
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
    final date = _dataController.dateController.date ?? toDate(kToday);
    final time = _dataController.timeController.time;
    final notes = _notesController.notesController.text;
    final rating = _dataController.rating;
    final orgasmAmount = _dataController.orgasmAmount;
    final duration = _dataController.durationController.time;
    final contraceptionOptions = _contraceptionController!.getSelectedOptions();
    final practicesOptions = _practicesController!.getSelectedOptions();
    final posesOptions = _posesController!.getSelectedOptions();
    final placeOptions = _placeController!.getSelectedOptions();

    var partners = _partnersController.getSelectedPartners();
    if (partners.isEmpty){
      await _partnersController.setDefault();
    }
    partners = _partnersController.getSelectedPartners();

    repo.updateEvent(event.event.id, date, time, notes);
    repo.updateEventData(event.event.id, rating!, duration, orgasmAmount, null);
    database.deleteEventPartners(event.event.id);
    database.deleteEventOptions(event.event.id);

    for (var p in partners.keys) {
      repo.loadEventPartner(event.event.id, p.id, partners[p]);
    }

    var allOptionsList = [
      contraceptionOptions, practicesOptions,
      posesOptions, placeOptions
    ].expand((x) => x).toList();
    for (var o in allOptionsList) {
      repo.loadOptions(event.event.id, o.id, null);
    }

    Navigator.of(context).pop(true);
    eventsUpdated.notifyUpdate();
  }

  @override
  void initState() {
    super.initState();
    _initControllers();
    _categoriesMapFuture = _getCategoriesList(database);
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
      alertString: AlertStrings.editEvent,
      alertButton: ButtonStrings.eventReturn,
    );
  }

  Future<Map<String, Category>> _getCategoriesList(AppDatabase db) async {
    List<Category> categories = await db.allCategories;
    var categoriesMap = { for (var v in categories) v.slug: v };
    return categoriesMap;
  }

  Future<void> _initControllers() async {
    final contraceptionOptions = await repo.getOptionsList(event.event.id, "contraception");
    final practicesOptions = await repo.getOptionsList(event.event.id, "practices");
    final posesOptions = await repo.getOptionsList(event.event.id, "poses");
    final placeOptions = await repo.getOptionsList(event.event.id, "place");

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
}