import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/repository/repository.dart';
import 'package:lustlist/widgets/basic_tile.dart';
import 'package:lustlist/widgets/info_row.dart';

class PartnerDataTile extends StatelessWidget {
  const PartnerDataTile({
    super.key,
    required this.partner,
  });

  final Partner partner;

  @override
  Widget build(BuildContext context) {
    var repo = EventRepository(database);

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
                    iconData: repo.getGenderIconData(partner),
                    title: "Gender:",
                    child: Text(
                      partner.gender.label,
                      style: TextStyle(
                          color: AppColors.eventData.text(context)
                      ),
                    )
                ),
                InfoRow(
                  iconData: Icons.cake,
                  title: "Birthday:",
                  child: Text(
                    _formatBirthday(),
                    style: TextStyle(
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
      return "Unknown";
    }
    final dateFormatted = DateFormat.yMMMMd().format(date);
    return dateFormatted;
  }
}
