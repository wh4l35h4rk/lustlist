import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class MedicalData extends StatelessWidget{
  const MedicalData({super.key,
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          AppIconData.medical,
          color: context.theme.eventDataColors.icon,
          size: context.sizes.iconBasic,
        ),
        Padding(
          padding: AppInsets.dataIcon,
          child: Text(
            StringFormatter.colon(DataStrings.type),
            style: TextStyle(
              color: context.theme.eventDataColors.title,
              fontWeight: FontWeight.bold,
              fontSize: context.sizes.titleSmall
            ),
          ),
        ),
        Wrap(
          children: [
            FutureBuilder<Widget>(
              future: getCategoryListText(database, context),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    MiscStrings.loading,
                    style: TextStyle(
                      color: context.theme.eventDataColors.text,
                      fontSize: context.sizes.textBasic,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    MiscStrings.errorLoadingData,
                    style: TextStyle(
                      color: context.theme.eventDataColors.text,
                      fontSize: context.sizes.textBasic,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return Text(
                    MiscStrings.noData,
                    style: TextStyle(
                      color: context.theme.eventDataColors.text,
                      fontSize: context.sizes.textBasic,
                    ),
                  );
                }
              },
            ),
          ],
        )
      ],
    );
  }

  Future<Widget> getCategoryListText(AppDatabase db, BuildContext context) async {
    final categoryNames = await db.getCategoryNamesOfEvent(event.event.id);
    String categoryString;
    if (categoryNames != null && categoryNames.isNotEmpty) {
      categoryString = categoryNames.join(", ");
    } else {
      categoryString = MiscStrings.unknown;
    }
    return Text(
      categoryString,
      style: TextStyle(
        fontSize: context.sizes.textBasic,
        color: context.theme.eventDataColors.text
      ),
    );
  }
}