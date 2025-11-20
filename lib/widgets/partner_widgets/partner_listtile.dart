import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import '../../repository/repository.dart';
import '../../utils.dart';


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
    var repo = EventRepository(database);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      child: ListTile(
          onTap: onTap,
          leading: Icon(
            repo.getGenderIconData(partner),
            color: AppColors.categoryTile.icon(context),
          ),
          title: Wrap(
            children: [
              Text(
                partner.name,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold
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
    final dateFormatted = DateFormat.yMMMMd().format(lastDate!);
    return dateFormatted;
  }

  Widget _getSubtitle(){
    if (lastDate == null || lastDate == defaultDate) {
      return Text(
        "No activities together yet!",
        style: TextStyle(
            fontStyle: FontStyle.italic
        ),
      );
    } else {
      return Wrap(
        children: [
          Text(
            "Last time together: ",
            style: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
          Text(_getLastEventText())
        ]);
    }
  }
}