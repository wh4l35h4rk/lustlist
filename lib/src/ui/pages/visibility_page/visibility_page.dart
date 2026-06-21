import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/src/ui/pages/visibility_page/widgets/shimmer_categories.dart';
import 'package:lustlist/src/ui/pages/visibility_page/widgets/toggle_category_tile.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';

class VisibilityPage extends StatefulWidget {
  const VisibilityPage({super.key});

  @override
  State<VisibilityPage> createState() => _VisibilityPageState();
}

class _VisibilityPageState extends State<VisibilityPage> {
  late Future<Map<String, Category>> _categoriesMapFuture;

  @override
  void initState() {
    _categoriesMapFuture = _getCategoriesList(database);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: PageTitleStrings.visibility,
        backButton: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(AppIconData.backButton),
          color: AppBarColors.icon(context),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: BasicTile(
              surfaceColor: MainColors.notesBottom(context)!,
              child: Text(
                MiscStrings.visibilityText,
                softWrap: true,
                textAlign: TextAlign.justify,
                style: AppStyles.noDataText(context),
              )
            )
          ),
          FutureBuilder(
            future: _categoriesMapFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerCategories();
              } else if (snapshot.hasError || !snapshot.hasData) {
                return ErrorTile();
              }

              final categoriesMap = snapshot.data!;

              return ListView(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ToggleCategoryTile(
                      category: categoriesMap['contraception']!,
                      iconData: AppIconData.contraception,
                    ),
                    ToggleCategoryTile(
                      category: categoriesMap['practices']!,
                      iconData: AppIconData.practices,
                      iconSize: 22,
                    ),
                    ToggleCategoryTile(
                      category: categoriesMap['solo practices']!,
                      iconData: AppIconData.toys,
                    ),
                    ToggleCategoryTile(
                      category: categoriesMap['poses']!,
                      iconData: AppIconData.poses,
                      iconSize: 27,
                    ),
                    ToggleCategoryTile(
                      category: categoriesMap['ejaculation']!,
                      iconData: AppIconData.ejaculation,
                    ),
                    ToggleCategoryTile(
                      category: categoriesMap['place']!,
                      iconData: AppIconData.place,
                    ),
                    ToggleCategoryTile(
                      category: categoriesMap['complicacies']!,
                      iconData: AppIconData.complicacies,
                    ),
                  ]
              );

            }
          )
        ],
      ),
      bottomNavigationBar: MainBottomNavigationBar(
        currentIndex: HomeNavigationController.pageIndex.value,
        context: context
      ),
    );
  }

  Future<Map<String, Category>> _getCategoriesList(AppDatabase db) async {
    List<Category> categories = await db.allCategories;
    var categoriesMap = { for (var v in categories) v.slug: v };
    return categoriesMap;
  }
}

