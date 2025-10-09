import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/notes_tile.dart';
import 'package:lustlist/widgets/add_widgets/select_partners_tile.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import '../../main.dart';
import '../../widgets/add_widgets/data_header.dart';
import '../../widgets/basic_tile.dart';

class AddSexEventPage extends StatefulWidget{
  const AddSexEventPage({super.key});

  @override
  State<AddSexEventPage> createState() => _AddSexEventPageState();
}

class _AddSexEventPageState extends State<AddSexEventPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;

  final _dataController = AddEventDataController();
  final _partnersController = SelectPartnersController();
  final _contraceptionController = AddCategoryController();
  final _practicesController = AddCategoryController();
  final _posesController = AddCategoryController();
  final _placeController = AddCategoryController();
  final _notesController = NotesTileController();

  @override
  void initState() {
    super.initState();
    _categoriesMapFuture = _getCategoriesList(database);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: MainAppBar(
            title: "Add new event",
            backButton: IconButton(
              onPressed: () => _showPopUp(context),
              icon: Icon(Icons.arrow_back_ios),
              color: AppColors.surface(context)
            ),
            editButton: IconButton(
              onPressed: () {
                final rating = _dataController.rating;
                final orgasmAmount = _dataController.orgasmAmount;
                final time = _dataController.timeController.time;
                final duration = _dataController.durationController.time;
                final partners = _partnersController.getSelectedPartners();
                final contraceptionOptions = _contraceptionController.getSelectedOptions();
                final practicesOptions = _practicesController.getSelectedOptions();
                final posesOptions = _posesController.getSelectedOptions();
                final placeOptions = _placeController.getSelectedOptions();
                final notes = _notesController.notesController.text;

                print("Rating: $rating");
                print("O's: $orgasmAmount");
                print("Time: $time");
                print("Duration: $duration");
                print("Partners: $partners");
                print("Contraception: ${contraceptionOptions.map((o) => o.name)}");
                print("Practices: ${practicesOptions.map((o) => o.name)}");
                print("Poses: ${posesOptions.map((o) => o.name)}");
                print("Place: ${placeOptions.map((o) => o.name)}");
                print("Notes: $notes");
              },
              icon: Icon(Icons.check),
              color: AppColors.surface(context)
            ),
          ),
          body: FutureBuilder<Map<String, Category>>(
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
                      iconData: Icons.favorite
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
                    iconData: CustomIcons.hand_lizard,
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
          bottomNavigationBar: MainBottomNavigationBar()
      ),
    );
  }

  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you sure you want to leave this menu? Your event won't be saved.",
            style: TextStyle(fontSize: 15, ),
            textAlign: TextAlign.justify,
          ),
          actions: [
            MaterialButton(
              child: const Text("Return to event"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              color: AppColors.appBar.surface(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                "Leave",
                style: TextStyle(color: AppColors.appBar.text(context)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, Category>> _getCategoriesList(AppDatabase db) async {
    List<Category> categories = await db.allCategories;
    var categoriesMap = { for (var v in categories) v.slug: v };
    return categoriesMap;
  }
}