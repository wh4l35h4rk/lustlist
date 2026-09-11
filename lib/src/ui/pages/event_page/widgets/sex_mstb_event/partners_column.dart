import 'package:flutter/material.dart';
import 'package:lustlist/src/config/enums/gender.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/pages/partners_page/partner_profile.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/database/database.dart';


class PartnersColumn extends StatelessWidget {
  const PartnersColumn({
    super.key,
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    var repo = EventRepository(database);

    return Column(
      children: [
        Row(
          children: [
            Text(
              _getPartnersTitle(),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: context.theme.eventDataColors.title,
                fontSize: context.sizes.titleLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              AppIconData.partners,
              size: context.sizes.iconBasic,
              color: context.theme.eventDataColors.leadingIcon,
            ),
          ],
        ),
        SizedBox(height: 5),
        event.partnersMap!.isEmpty ?
          Text(
            AlertStrings.noPartnersPassed,
            style: TextStyle(
              color: context.theme.eventDataColors.text,
              fontSize: context.sizes.textBasic,
              fontStyle: FontStyle.italic
            ),
          ) :
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var partner in event.partnersMap!.keys)
                      OutlinedButton(
                        onPressed: () => _onPartnerTap(context, repo, partner),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1.2, color: context.theme.eventDataColors.border),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              partner.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: context.sizes.textBasic,
                                color: context.theme.eventDataColors.text
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              partner.gender.iconData,
                              size: partner.gender == Gender.nonbinary
                                  ? context.sizes.iconNoninaryBasic : context.sizes.iconBasic,
                              color: context.theme.eventDataColors.icon,
                            )
                          ],
                        ),
                      )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var amount in event.partnersMap!.values)
                      Text(
                        StringFormatter.orgasmsAmount(amount, true),
                        style: TextStyle(
                          fontSize: context.sizes.textBasic,
                          color: context.theme.eventDataColors.text
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }

  String _getPartnersTitle() {
    final partners = event.partnersMap!.keys;
    if (partners.length > 1) {
      return StringFormatter.colon(PageTitleStrings.partners);
    } else if (partners.length == 1) {
      return StringFormatter.colon(MiscStrings.partnerOne);
    } else {
      return StringFormatter.colon(PageTitleStrings.partners);
    }
  }

  Future<void> _onPartnerTap(BuildContext context, EventRepository repo, Partner partner) async {
    Partner? unknownPartner = await repo.getUnknownPartner();
    if (unknownPartner != null && partner == unknownPartner) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnerProfile(
          partner: partner,
          previousEventId: event.event.id
        ),
      ),
    );
  }
}