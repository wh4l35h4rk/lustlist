import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/ui/main.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.event,
    required this.title,
    required this.categorySlug,
    required this.iconData,
    this.iconSize = AppSizes.iconBasic,
    this.onNoResultsText = MiscStrings.notStated,
  });

  final CalendarEvent event;
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
                  fontSize: AppSizes.titleLarge,
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
                return Text(
                  MiscStrings.loading,
                  style: TextStyle(
                    color: AppColors.categoryTile.text(context),
                    fontSize: AppSizes.titleSmall,
                  )
                );
              } else if (snapshot.hasError) {
                return Text(
                    MiscStrings.errorLoadingData,
                    style: TextStyle(
                      color: AppColors.categoryTile.text(context),
                      fontSize: AppSizes.titleSmall,
                    )
                );
              } else if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return Text(
                  MiscStrings.noData,
                  style: TextStyle(
                    color: AppColors.categoryTile.text(context),
                    fontSize: AppSizes.titleSmall,
                  )
                );
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

