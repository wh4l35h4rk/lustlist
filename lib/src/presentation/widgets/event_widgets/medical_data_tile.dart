import 'package:flutter/material.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/presentation/main.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/profile_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';


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
        Icon(Icons.medical_services, color: AppColors.eventData.icon(context),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            colon(DataStrings.type),
            style: TextStyle(
                color: AppColors.eventData.title(context),
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.titleSmall
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
                    ProfileStrings.loading,
                    style: TextStyle(
                      color: AppColors.eventData.text(context),
                      fontSize: AppSizes.textBasic,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    ProfileStrings.errorLoadingData,
                    style: TextStyle(
                      color: AppColors.eventData.text(context),
                      fontSize: AppSizes.textBasic,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return Text(
                    ProfileStrings.noData,
                    style: TextStyle(
                      color: AppColors.eventData.text(context),
                      fontSize: AppSizes.textBasic,
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

  Future<Widget> getCategoryListText(AppDatabase db, context) async {
    final categoryNames = await db.getCategoryNamesOfEvent(event.event.id);
    String categoryString;
    if (categoryNames != null && categoryNames.isNotEmpty) {
      categoryString = categoryNames.join(", ");
    } else {
      categoryString = DataStrings.unknown;
    }
    return Text(
      categoryString,
      style: TextStyle(
        fontSize: AppSizes.textBasic,
        color: AppColors.eventData.text(context)
      ),
    );
  }
}