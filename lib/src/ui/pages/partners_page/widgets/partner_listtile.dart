import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/enums/gender.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';


class PartnerListTile extends StatelessWidget {
  const PartnerListTile({
    required this.partner,
    required this.onTap,
    this.lastDate,
    super.key,
  });

  final GestureTapCallback onTap;
  final Partner partner;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppInsets.listTile,
      child: ListTile(
          onTap: onTap,
          leading: Icon(
            partner.gender.iconData,
            size: partner.gender == Gender.nonbinary
                ? AppSizes.iconBasic - 3 : AppSizes.iconBasic,
            color: AppColors.categoryTile.icon(context),
          ),
          title: Wrap(
            children: [
              Text(
                partner.name,
                style: TextStyle(
                  fontSize: AppSizes.titleLarge,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          subtitle: _getSubtitle(),
          trailing: Icon(Icons.arrow_forward_ios)
      ),
    );
  }

  String _getLastEventText() {
    final dateFormatted = DateFormatter.dateWithDay(lastDate!);
    return dateFormatted;
  }

  Widget _getSubtitle(){
    if (lastDate == null || lastDate == defaultDate) {
      return Text(
        MiscStrings.noPartnerEvents,
        style: TextStyle(
          fontSize: AppSizes.textBasic,
          fontStyle: FontStyle.italic
        ),
      );
    } else {
      return Wrap(
        children: [
          Text(
            MiscStrings.lastTimeTogether,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: AppSizes.textBasic,
            ),
          ),
          Text(
            _getLastEventText(),
            style: TextStyle(
              fontSize: AppSizes.textBasic,
            ),
          )
        ]);
    }
  }
}