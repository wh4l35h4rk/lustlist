import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/widgets/event_listtile.dart';


class AllEventsListTile extends StatelessWidget {
  const AllEventsListTile({
    required this.event,
    required this.onTap,
    super.key,
  });

  final CalendarEvent event;
  final GestureTapCallback onTap;


  String _getTitle() {
    return StringFormatter.dateTimeTitle(event.event.date, event.event.time);
  }


  Future<String> _getSubtitleMedical(AppDatabase db) async {
    final categoryNames = await db.getCategoryNamesOfEvent(event.getEventId());
    if (categoryNames != null && categoryNames.isNotEmpty) {
      return "${event.type.name}; ${categoryNames.join(", ")}";
    } else {
      return event.type.name;
    }
  }

  String _getSubtitle() {
    final typeSlug = event.getTypeSlug();
    String partners;
    switch (typeSlug) {
      case "sex":
        partners = StringFormatter.partnerNamesTitle(event.getPartnerNames());
      case "masturbation":
        partners = event.type.name;
      default:
        partners = '';
    }

    if (event.data != null) {
      String duration = StringFormatter.duration(event.getDuration(), false);
      return [partners, duration].join("; ");
    } else {
      return "$partners; ${MiscStrings.durationUnknown}";
    }
  }

  Color _getBorderColor(BuildContext context) {
    final typeSlug = event.getTypeSlug();
    if ((typeSlug == "sex" || typeSlug == "masturbation") && event.data != null) {
      final int rating = event.data!.rating;
      switch (rating) {
        case 1:
          return Colors.red;
        case 2:
          return Colors.orange;
        case 3:
          return Colors.amber;
        case 4:
          return Colors.lime;
        case 5:
          return Colors.green;
        default:
          return AppColors.defaultTile(context);
      }
    } else {
      return AppColors.defaultTile(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String typeSlug = event.type.slug;

    return EventListTile(
      title: _getTitle(),
      subtitleWidget: typeSlug == "medical"
          ? FutureBuilder<String>(
        future: _getSubtitleMedical(database),
        builder: (context, snapshot) {
          String string;
          if (snapshot.connectionState == ConnectionState.waiting) {
            string = MiscStrings.loading;
          } else if (snapshot.hasError) {
            string = MiscStrings.errorLoadingData;
          } else {
            string = snapshot.data ?? MiscStrings.noData;
          }
          return Text(
              string,
              style: AppStyles.basicText(context)
          );
        },
      )
          : Text(
          _getSubtitle(),
          style: AppStyles.basicText(context)
      ),
      iconData: iconDataMap[event.getTypeId()],
      onTap: onTap,
      hasBorder: true,
      borderColor: _getBorderColor(context),
      titleSize: AppSizes.titleSmall,
    );
  }
}