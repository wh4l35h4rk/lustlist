import 'package:flutter/material.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/db/events_options.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';
import '../../database.dart';
import '../../example_utils.dart';

class StiTile extends StatelessWidget{
  final TestEvent event;

  const StiTile({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
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
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                CustomIcons.viruses,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          SizedBox(height: 5,),
          FutureBuilder<List<EOption>>(
            future: _getOptions(database, context, "sti"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              } else if (snapshot.hasError) {
                return const Text("Error loading data");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text("Not stated", style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),);
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
                                    color: colorBlend(
                                        Theme.of(context).colorScheme.onPrimaryContainer,
                                        Theme.of(context).colorScheme.primaryContainer,
                                        0.8
                                    )!,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  option.name,
                                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
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
                                        Icon(Icons.question_mark, size: 15),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Loading...",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  else if (!snapshot.hasData) {
                                    return Row(
                                      children: [
                                        Icon(Icons.question_mark, size: 15,),
                                        const SizedBox(width: 5),
                                        Text(
                                          "No data",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                                          color: Theme.of(context).colorScheme.onPrimaryContainer,
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