import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/ui/widgets/event_listtile.dart';


class PartnerEventListTile extends StatelessWidget {
  const PartnerEventListTile({
    required this.event,
    required this.onTap,
    required this.partnerOrgasms,
    required this.iconData,
    super.key,
  });

  final CalendarEvent event;
  final GestureTapCallback onTap;
  final int? partnerOrgasms;
  final IconData? iconData;

  String _getTitle() {
    return StringFormatter.dateTimeTitle(event.event.date, event.event.time);
  }

  String _getSubtitle() {
    String duration = StringFormatter.duration(event.getDuration(), false);
    String orgasms = StringFormatter.orgasmsAmount(partnerOrgasms, false);
    return "$duration, $orgasms";
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
    return EventListTile(
      title: _getTitle(),
      subtitleWidget: Text(_getSubtitle()),
      iconData: iconData,
      onTap: onTap,
      hasBorder: true,
      borderColor: _getBorderColor(context),
      titleSize: AppSizes.titleSmall,
    );
  }
}