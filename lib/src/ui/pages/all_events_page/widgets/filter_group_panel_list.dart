import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';


class FilterGroupPanelList extends StatelessWidget {
  final List<String> headersList;
  final List<Widget> expandedBodiesList;

  const FilterGroupPanelList({
    super.key,
    required this.headersList,
    required this.expandedBodiesList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: headersList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: FilterGroupPanel(
            header: headersList[index],
            expandedBody: expandedBodiesList[index],
          ),
        );
      }
    );
  }
}


class FilterGroupPanel extends StatefulWidget {
  final String header;
  final Widget expandedBody;

  const FilterGroupPanel({
    super.key,
    required this.header,
    required this.expandedBody,
  });

  @override
  State<FilterGroupPanel> createState() => _FilterGroupPanelState();
}

class _FilterGroupPanelState extends State<FilterGroupPanel> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.header,
                style: TextStyle(
                  fontSize: AppSizes.titleSmall
                ),
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: Duration(milliseconds: 200),
                child: Icon(AppIconData.dropList),
              )
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: ClipRect(
            child: ConstrainedBox(
              constraints: isExpanded
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 0),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  widget.expandedBody,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}