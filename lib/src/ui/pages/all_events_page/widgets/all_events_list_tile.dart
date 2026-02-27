import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/enums/type.dart';
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
    final type = event.type;
    String partners;
    switch (type) {
      case EventType.sex:
        partners = StringFormatter.partnerNamesTitle(event.getPartnerNames());
      case EventType.masturbation:
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
    final type = event.type;
    if ((type == EventType.sex || type == EventType.masturbation) && event.data != null) {
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

  bool multiplePartners(){
    EventType type = event.type;
    if (type == EventType.sex && event.getPartnerNames().isNotEmpty) {
      num len = event.getPartnerNames().length;
      if (len > 1) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    EventType type = event.type;

    return EventListTile(
      title: _getTitle(),
      subtitleWidget: type == EventType.medical
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
      iconData: multiplePartners() ? CategoryIcons.two : type.iconData,
      onTap: onTap,
      hasBorder: true,
      borderColor: _getBorderColor(context),
      titleSize: AppSizes.titleSmall,
    );
  }
}