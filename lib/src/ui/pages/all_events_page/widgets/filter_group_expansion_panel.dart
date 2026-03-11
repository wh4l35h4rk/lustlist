import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class FilterGroupExpansionPanel extends StatelessWidget {
  final List<String> headersList;
  final List<Widget> expandedBodiesList;

  const FilterGroupExpansionPanel({
    super.key,
    required this.headersList,
    required this.expandedBodiesList,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      children: List.generate(headersList.length, (index) {
        return ExpansionPanelRadio(
          headerBuilder: (_, _) => ListTile(
            title: Text(
              headersList[index],
              style: TextStyle(
                fontSize: AppSizes.titleSmall
              ),
            ),
          ),
          body: expandedBodiesList[index],
          value: index,
        );
      }),
    );
  }
}