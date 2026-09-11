import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
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


  @override
  Widget build(BuildContext context) {
    return EventListTile(
      title: _getTitle(),
      subtitleWidget: Text(
        _getSubtitle(),
        style: TextStyle(fontSize: context.sizes.textBasic),
      ),
      iconData: iconData,
      onTap: onTap,
      hasBorder: true,
      borderColor: ConstColors.getBorderColor(event, context),
      titleSize: context.sizes.titleSmall,
    );
  }
}