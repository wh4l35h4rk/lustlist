import 'package:flutter/material.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
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
      margin: const EdgeInsets.all(10),
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
                      style: TextStyle(
                        fontSize: AppSizes.textBasic,
                        color: AppColors.eventData.text(context)
                      ),
                    )
                ),
                InfoRow(
                  iconData: Icons.cake,
                  title: StringFormatter.colon(DataStrings.birthday),
                  child: Text(
                    _formatBirthday(),
                    style: TextStyle(
                      fontSize: AppSizes.textBasic,
                      color: AppColors.eventData.text(context)
                    ),
                  )
                )
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
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
