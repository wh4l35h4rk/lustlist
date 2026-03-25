import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';

class PartnerDataTile extends StatelessWidget {
  const PartnerDataTile({
    super.key,
    required this.partner,
  });

  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return BasicTile(
      surfaceColor: AppColors.eventData.surface(context),
      margin: AppInsets.headerTile,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoRow(
                  iconData: partner.gender.iconData,
                  title: StringFormatter.colon(DataStrings.gender),
                  child: Text(
                    partner.gender.label,
                    style: AppStyles.eventDataBasicText(context)
                  )
                ),
                InfoRow(
                  iconData: AppIconData.age,
                  title: StringFormatter.colon(DataStrings.age),
                  child: Text(
                    partner.age != null
                      ? StringFormatter.age(partner.age!.toString())
                      : MiscStrings.unknown,
                    style: AppStyles.eventDataBasicText(context),
                  ),
                ),
                InfoRow(
                  iconData: AppIconData.birthday,
                  title: StringFormatter.colon(DataStrings.birthday),
                  child: Text(
                    _formatBirthday(),
                    style: AppStyles.eventDataBasicText(context)
                  )
                )
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  AppIconData.partners,
                  color: AppColors.eventData.leadingIcon(context),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  String _formatBirthday() {
    DateTime? date = partner.birthday;
    if (date == null) {
      return MiscStrings.unknown;
    }
    final dateFormatted = DateFormatter.dateWithDay(date);
    return dateFormatted;
  }
}
