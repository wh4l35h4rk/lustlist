import 'package:flutter/material.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/db/events_options.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';
import '../../colors.dart';
import '../../database.dart';
import '../../example_utils.dart';
import '../basic_tile.dart';

class StiTile extends StatelessWidget{
  final TestEvent event;

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
                "STI:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.categoryTile.title(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                CustomIcons.viruses,
                color: AppColors.categoryTile.leadingIcon(context),
              ),
            ],
          ),
          SizedBox(height: 5,),
          FutureBuilder<List<EOption>>(
            future: _getOptions(database, context, "sti"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...", style: TextStyle(color: AppColors.categoryTile.text(context)),);
              } else if (snapshot.hasError) {
                return Text("Error loading data", style: TextStyle(color: AppColors.categoryTile.text(context)),);
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text("Not stated", style: TextStyle(color: AppColors.categoryTile.text(context)),);
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  option.name,
                                  style: TextStyle(color: AppColors.categoryTile.text(context)),
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
                                          size: 15,
                                          color: AppColors.categoryTile.icon(context),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Loading...",
                                          style: TextStyle(
                                            color: AppColors.categoryTile.text(context),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  else if (!snapshot.hasData) {
                                    return Row(
                                      children: [
                                        Icon(Icons.question_mark, size: 15, color: AppColors.categoryTile.icon(context),),
                                        const SizedBox(width: 5),
                                        Text(
                                          "No data",
                                          style: TextStyle(
                                            color: AppColors.categoryTile.text(context),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError){
                                    return Row(
                                      children: [
                                        Icon(Icons.bug_report, size: 15,),
                                        const SizedBox(width: 5),
                                        Text(
                                          "No data",
                                          style: TextStyle(
                                            color: AppColors.categoryTile.text(context),
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  final status = snapshot.data!;
                                  IconData iconData;
                                  String label = status.label;

                                  switch (status) {
                                    case TestStatus.positive:
                                      iconData = Icons.check;
                                    case TestStatus.negative:
                                      iconData = Icons.close;
                                    case TestStatus.waiting:
                                      iconData = Icons.autorenew;
                                  }

                                  return Row(
                                    children: [
                                      Icon(iconData, size: 15),
                                      const SizedBox(width: 5),
                                      Text(
                                        label,
                                        style: TextStyle(
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
    List<EOption> options = await db.getOptionsByCategory(event.event.id, categoryId);
    return options;
  }

  Future<IconData> _getIcon(AppDatabase db, EOption option) async {
    TestStatus? statusData = await db.getTestResult(event.event.id, option.id);
    IconData iconsData;
    switch (statusData){
      case TestStatus.positive:
        iconsData = Icons.check;
      case TestStatus.negative:
        iconsData = Icons.close;
      case TestStatus.waiting:
        iconsData = Icons.autorenew;
      default:
        iconsData = Icons.question_mark;
    }
    return iconsData;
  }

  Future<String> _getStatusLabel(AppDatabase db, EOption option) async {
    TestStatus? statusData = await db.getTestResult(event.event.id, option.id);
    if (statusData != null) {
      return statusData.label;
    } else {
      return "No data";
    }
  }
}