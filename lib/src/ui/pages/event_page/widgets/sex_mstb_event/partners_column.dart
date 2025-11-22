import 'package:flutter/material.dart';
import 'package:lustlist/src/ui/main.dart';
import 'package:lustlist/src/ui/pages/partners_page/widgets/partner_profile.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/page_strings.dart';
import 'package:lustlist/src/config/strings/profile_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';
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
                color: AppColors.eventData.title(context),
                fontSize: AppSizes.titleLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.person,
              color: AppColors.eventData.leadingIcon(context),
            ),
          ],
        ),
        SizedBox(height: 5,),
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
                        side: BorderSide(width: 1.2, color: AppColors.eventData.border(context)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            partner.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: AppSizes.textBasic,
                              color: AppColors.eventData.text(context)
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            repo.getGenderIconData(partner),
                            color: AppColors.eventData.icon(context),
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
                      _getOrgasmsText(amount),
                      style: TextStyle(
                        fontSize: AppSizes.textBasic,
                        color: AppColors.eventData.text(context)
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
      return colon(PageStrings.partners);
    } else if (partners.length == 1) {
      return colon(ProfileStrings.partnerOne);
    } else {
      throw FormatException("No partners passed");
    }
  }

  String _getOrgasmsText(int orgasmsAmount) {
    final String amountString = orgasmsAmount.toString();
    final String orgasmsString;
    if (orgasmsAmount == 1) {
      orgasmsString = ProfileStrings.orgasmOne;
    } else {
      orgasmsString = ProfileStrings.orgasmsMany;
    }
    return "$amountString $orgasmsString";
  }

  Future<void> _onPartnerTap(BuildContext context, EventRepository repo, Partner partner) async {
    final result = await Navigator.push(
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