import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/select_partners_tile.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import '../../main.dart';
import '../../widgets/add_widgets/sex_event_header.dart';

class AddSexEventPage extends StatefulWidget{
  const AddSexEventPage({super.key});

  @override
  State<AddSexEventPage> createState() => _AddSexEventPageState();
}

class _AddSexEventPageState extends State<AddSexEventPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;

  @override
  void initState() {
    super.initState();
    _categoriesMapFuture = _getCategoriesList(database);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          title: "Add new event",
          backButton: IconButton(
            onPressed: () => _showPopUp(context),
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.surface(context)
          ),
          editButton: IconButton(
            onPressed: () {
              //TODO: save event
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
                AddSexEventData(),
                SelectPartnersTile(),
                AddCategoryTile(
                  category: categoriesMap['contraception']!,
                  iconData: CategoryIcons.condom,
                ),
                AddCategoryTile(
                  category: categoriesMap['practices']!,
                  iconData: CustomIcons.hand_lizard,
                  iconSize: 22,
                ),
                AddCategoryTile(
                  category: categoriesMap['poses']!,
                  iconData: CategoryIcons.sexMove,
                  iconSize: 27,
                ),
                AddCategoryTile(
                  category: categoriesMap['place']!,
                  iconData: Icons.bed,
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: MainBottomNavigationBar()
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
              child: const Text("Leave"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            ),
            MaterialButton(
              child: const Text("Return"),
              onPressed: () {
                Navigator.of(context).pop();
              },
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