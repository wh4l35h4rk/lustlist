import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/domain/entities/partner_dated.dart';
import 'package:lustlist/src/ui/pages/partners_page/widgets/partner_listtile.dart';
import 'package:lustlist/src/core/widgets/animated_list_base.dart';


class PartnersAnimatedList extends AnimatedListBase<PartnerWithDate> {
  const PartnersAnimatedList({
    super.key,
    required super.newList,
    required this.onTap,
  });

  final Function(PartnerWithDate item) onTap;

  @override
  State<PartnersAnimatedList> createState() => _PartnersAnimatedListState();
}


class _PartnersAnimatedListState extends AnimatedListBaseState<PartnerWithDate, PartnersAnimatedList> {
  @override
  Widget buildItem(BuildContext context,
      int index,
      Animation<double> animation,) {
    return SizeTransition(
        sizeFactor: animation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PartnerListTile(
              partner: list[index].partner,
              onTap: () => widget.onTap(list[index]),
              lastDate: list[index].lastDate,
            ),
            Padding(
              padding: AppInsets.divider,
              child: Divider(
                height: AppSizes.dividerMinimal,
              ),
            )
          ],
        )
    );
  }

  @override
  Widget buildRemovedItem(PartnerWithDate item,
      BuildContext context,
      Animation<double> animation,) {
    return SizeTransition(
        sizeFactor: animation,
        child: PartnerListTile(
          partner: item.partner,
          lastDate: item.lastDate,
        ),
    );
  }
}