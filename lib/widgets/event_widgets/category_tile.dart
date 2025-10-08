import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';

import '../basic_tile.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.event,
    required this.title,
    required this.categorySlug,
    required this.iconData,
    this.iconSize = 24,
    this.onNoResultsText = "Not stated",
  });

  final TestEvent event;
  final String title;
  final String categorySlug;
  final IconData iconData;
  final double iconSize;
  final String onNoResultsText;

  @override
  Widget build(BuildContext context) {
    return BasicTile(
      surfaceColor: AppColors.categoryTile.surface(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.categoryTile.title(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                iconData,
                size: iconSize,
                color: AppColors.categoryTile.leadingIcon(context),
              ),
            ],
          ),
          SizedBox(height: 5,),
          FutureBuilder<Widget>(
            future: _getOptions(database, context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              } else if (snapshot.hasError) {
                return const Text("Error loading data");
              } else if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return const Text("No data");
              }
            },
          ),
        ],
      ),
    );
  }

  Future<Widget> _getOptions(AppDatabase db, context) async {
    int categoryId = await db.getCategoryIdBySlug(categorySlug);
    List<EOption> options = await db.getEventOptionsByCategory(event.event.id, categoryId);

    if (options.isEmpty){
      return Text(onNoResultsText);
    } else {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [for (var option in options)
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.categoryTile.border(context),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(option.name),
          ),
        ],
      );
    }
  }
}

