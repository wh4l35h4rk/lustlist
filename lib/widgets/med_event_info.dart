import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/widgets/notes_tile.dart';

import '../database.dart';


class MedEventInfo extends StatelessWidget {
  final TestEvent event;

  const MedEventInfo({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MedTile(event: event),
        NotesTile(event: event),
        SizedBox(height: 10,)
      ],
    );
  }
}

class MedTile extends StatelessWidget{
  final TestEvent event;

  const MedTile({
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
        color: Theme.of(context).colorScheme.primary,
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
                "Type:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                iconDataMap[event.getTypeId()],
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ],
          ),
          SizedBox(height: 5,),
          FutureBuilder<Widget>(
            future: _getOptions(database, context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...", style: TextStyle(color: Theme.of(context).colorScheme.surface),);
              } else if (snapshot.hasError) {
                return Text("Error loading data", style: TextStyle(color: Theme.of(context).colorScheme.surface),);
              } else if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return Text("No data", style: TextStyle(color: Theme.of(context).colorScheme.surface),);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<Widget> _getOptions(AppDatabase db, context) async {
    int categoryId = await db.getCategoryIdBySlug("medical");
    List<EOption> options = await db.getOptionsByCategory(event.event.id, categoryId);

    if (options.isEmpty){
      return Text("Not stated", style: TextStyle(color: Theme.of(context).colorScheme.surface),);
    } else {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [for (var option in options)
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(option.name, style: TextStyle(color: Theme.of(context).colorScheme.surface),),
          ),
        ],
      );
    }
  }
}