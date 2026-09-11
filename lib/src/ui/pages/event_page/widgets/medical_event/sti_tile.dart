import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/enums/test_status.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/widgets/shimmer_sti.dart';


class StiTile extends StatelessWidget{
  final CalendarEvent event;

  const StiTile({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return BasicTile(
      surfaceColor: context.theme.categoryTileColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringFormatter.colon(DataStrings.sti),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: context.theme.categoryTileColors.title,
                  fontSize: context.sizes.titleLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                AppIconData.sti,
                size: context.sizes.iconBasic,
                color: context.theme.categoryTileColors.leadingIcon,
              ),
            ],
          ),
          SizedBox(height: 5),
          FutureBuilder<List<EOption>>(
            future: _getOptions(database, "sti"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerSti();
              } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                return ErrorTile();
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
                                    color: context.theme.categoryTileColors.border,
                                  ),
                                  borderRadius: BorderRadius.circular(context.sizes.containerTileRadius),
                                ),
                                child: Text(
                                  option.name,
                                  style: TextStyle(
                                    fontSize: context.sizes.textBasic,
                                    color: context.theme.categoryTileColors.text
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
                                          AppIconData.noData,
                                          size: context.sizes.iconSmall,
                                          color: context.theme.categoryTileColors.icon,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          MiscStrings.loading,
                                          style: TextStyle(
                                            fontSize: context.sizes.textBasic,
                                            color: context.theme.categoryTileColors.text,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  else if (!snapshot.hasData) {
                                    return Row(
                                      children: [
                                        Icon(
                                          AppIconData.noData,
                                          size: context.sizes.iconSmall,
                                          color: context.theme.categoryTileColors.icon
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          MiscStrings.noData,
                                          style: TextStyle(
                                            fontSize: context.sizes.textBasic,
                                            color: context.theme.categoryTileColors.text,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError){
                                    return Row(
                                      children: [
                                        Icon(AppIconData.error, size: context.sizes.iconSmall),
                                        const SizedBox(width: 5),
                                        Text(
                                          MiscStrings.noData,
                                          style: TextStyle(
                                            fontSize: context.sizes.textBasic,
                                            color: context.theme.categoryTileColors.text,
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
                                      Icon(iconData, size: context.sizes.iconSmall),
                                      const SizedBox(width: 5),
                                      Text(
                                        label,
                                        style: TextStyle(
                                          fontSize: context.sizes.textBasic,
                                          color: context.theme.categoryTileColors.text,
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

  Future<List<EOption>> _getOptions(AppDatabase db, String slug) async {
    int categoryId = await db.getCategoryIdBySlug(slug);
    List<EOption> options = await db.getEventOptionsByCategory(event.event.id, categoryId);
    return options;
  }
}