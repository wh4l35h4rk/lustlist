import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/enums/gender.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class PartnerListTile extends StatelessWidget {
  const PartnerListTile({
    required this.partner,
    this.onTap,
    this.lastDate,
    super.key,
  });

  final GestureTapCallback? onTap;
  final Partner partner;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppInsets.listTile,
      child: ListTile(
          onTap: onTap,
          leading: _getLeading(context),
          title: Wrap(
            children: [
              Text(
                partner.name,
                style: TextStyle(
                  fontSize: context.sizes.titleLarge,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          subtitle: _getSubtitle(context),
          trailing: Icon(
            AppIconData.arrowRight,
            size: context.sizes.iconBasic,
          )
      ),
    );
  }

  String _getLastEventText() {
    final dateFormatted = DateFormatter.dateWithDay(lastDate!);
    return dateFormatted;
  }

  Widget _getSubtitle(BuildContext context){
    if (lastDate == null || lastDate == defaultDate) {
      return Text(
        MiscStrings.noPartnerEvents,
        style: AppStyles.noDataText(context)
      );
    } else {
      return Wrap(
        children: [
          Text(
            MiscStrings.lastTimeTogether,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: context.sizes.textBasic,
            ),
          ),
          Text(
            _getLastEventText(),
            style: TextStyle(
              fontSize: context.sizes.textBasic,
            ),
          )
        ]);
    }
  }

  Widget _getLeading(BuildContext context){
    String? picturePath = partner.picturePath;
    if (picturePath == null || picturePath == ""){
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Icon(
          partner.gender.iconData,
          size: partner.gender == Gender.nonbinary
              ? context.sizes.iconNoninaryBasic : context.sizes.iconBasic,
          color: context.theme.categoryTileColors.icon,
        ),
      );
    } else {
      return CircleAvatar(
        radius: context.sizes.avatarRadiusSmall,
        child: ClipOval(
          child: Image.file(
            width: context.sizes.avatarSize,
            height: context.sizes.avatarSize,
            File(picturePath),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}