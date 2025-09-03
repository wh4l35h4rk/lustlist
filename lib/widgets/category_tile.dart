import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';

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
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                iconData,
                size: iconSize,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          SizedBox(height: 5,),
          FutureBuilder<Widget>(
            future: _getPractices(database, context),
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

  Future<Widget> _getPractices(AppDatabase db, context) async {
    int categoryId = await db.getCategoryIdBySlug(categorySlug);
    List<EOption> options = await db.getOptionsByCategory(event.event.id, categoryId);

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
                color: Theme.of(context).colorScheme.secondaryFixedDim,
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

