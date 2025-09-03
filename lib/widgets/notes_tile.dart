import 'package:flutter/material.dart';
import 'package:lustlist/test_event.dart';

class NotesTile extends StatelessWidget {
  const NotesTile({
    super.key,
    required this.event,
  });

  final TestEvent event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 18.0,
            right: 18.0,
            top: 18.0,
            bottom: 12,
          ),
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 5
          ),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notes",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.notes,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(18.0),
          margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 5
          ),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: _blend(
              Theme.of(context).colorScheme.secondaryContainer,
              Theme.of(context).colorScheme.surface,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: Expanded(child: _getNotes()),
        ),
      ],
    );
  }

  Text _getNotes() {
    final String? notes = event.event.notes;
    if (notes != null) {
      return Text(notes);
    } else {
      return Text(
        "There are no notes yet.",
        style: TextStyle(
          fontStyle: FontStyle.italic
        ),
      );
    }
  }

  Color? _blend(Color color1, color2) {
    final double amount = 0.5;
    return Color.lerp(color1, color2, amount)!;
  }
}

