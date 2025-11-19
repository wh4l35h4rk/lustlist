import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import '../../repository.dart';


class PartnerListTile extends StatelessWidget {
  const PartnerListTile({
    required this.partner,
    super.key,
    required this.onTap,
  });

  final GestureTapCallback onTap;
  final Partner partner;

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
    DateTime date = partner.lastEventDate;
    final dateFormatted = DateFormat.yMMMMd().format(date);
    return dateFormatted;
  }

  Widget _getSubtitle(){
    DateTime date = partner.lastEventDate;
    if (date == DateTime(1970, 1, 1)) {
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