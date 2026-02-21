import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/enums/test_status.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';

class StiTile extends StatelessWidget{
  final CalendarEvent event;

  const StiTile({
    super.key,
    required this.event,
  });

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
                DataStrings.sti,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.categoryTile.title(context),
                  fontSize: AppSizes.titleLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                CustomIcons.viruses,
                color: AppColors.categoryTile.leadingIcon(context),
              ),
            ],
          ),
          SizedBox(height: 5),
          FutureBuilder<List<EOption>>(
            future: _getOptions(database, context, "sti"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  MiscStrings.loading,
                  style: TextStyle(
                    color: AppColors.categoryTile.text(context),
                    fontSize: AppSizes.textBasic,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  MiscStrings.errorLoadingData,
                  style: TextStyle(
                    color: AppColors.categoryTile.text(context),
                    fontSize: AppSizes.textBasic,
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text(
                  MiscStrings.notStated,
                  style: TextStyle(
                    color: AppColors.categoryTile.text(context),
                    fontSize: AppSizes.textBasic,
                  ),
                );
              } else {
                final options = snapshot.data!;

                return IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var option in options)
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.categoryTile.border(context),
                                  ),
                                  borderRadius: BorderRadius.circular(AppSizes.containerTileRadius),
                                ),
                                child: Text(
                                  option.name,
                                  style: TextStyle(
                                    fontSize: AppSizes.textBasic,
                                    color: AppColors.categoryTile.text(context)
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var index = 0; index < options.length; index++)
                              FutureBuilder<TestStatus?>(
                                future: database.getTestResult(event.event.id, options[index].id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Row(
                                      children: [
                                        Icon(
                                          Icons.question_mark,
                                          size: AppSizes.iconSmall,
                                          color: AppColors.categoryTile.icon(context),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          MiscStrings.loading,
                                          style: TextStyle(
                                            fontSize: AppSizes.textBasic,
                                            color: AppColors.categoryTile.text(context),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  else if (!snapshot.hasData) {
                                    return Row(
                                      children: [
                                        Icon(
                                          Icons.question_mark,
                                          size: AppSizes.iconSmall,
                                          color: AppColors.categoryTile.icon(context)
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          MiscStrings.noData,
                                          style: TextStyle(
                                            fontSize: AppSizes.textBasic,
                                            color: AppColors.categoryTile.text(context),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError){
                                    return Row(
                                      children: [
                                        Icon(Icons.bug_report, size: AppSizes.iconSmall),
                                        const SizedBox(width: 5),
                                        Text(
                                          MiscStrings.noData,
                                          style: TextStyle(
                                            fontSize: AppSizes.textBasic,
                                            color: AppColors.categoryTile.text(context),
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  final status = snapshot.data!;
                                  IconData iconData = status.iconData;
                                  String label = status.label;

                                  return Row(
                                    children: [
                                      Icon(iconData, size: AppSizes.iconSmall),
                                      const SizedBox(width: 5),
                                      Text(
                                        label,
                                        style: TextStyle(
                                          fontSize: AppSizes.textBasic,
                                          color: AppColors.categoryTile.text(context),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                          ],
                        ),
                      ),

                    ],
                  ),
                );

              }
            },
          ),
        ],
      ),
    );
  }

  Future<List<EOption>> _getOptions(AppDatabase db, context, String slug) async {
    int categoryId = await db.getCategoryIdBySlug(slug);
    List<EOption> options = await db.getEventOptionsByCategory(event.event.id, categoryId);
    return options;
  }
}