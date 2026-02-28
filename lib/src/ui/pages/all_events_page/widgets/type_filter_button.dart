import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/ui/controllers/filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/add_remove_all_button.dart';

class TypeFilterButton extends StatelessWidget {
  const TypeFilterButton({
    required this.controller,
    super.key
  });

  final FilterController<EventType> controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.selectedValues,
      builder: (context, selectedList, child) {
        bool selectedAll = controller.allSelected();

        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: selectedAll
                ? AppColors.surface(context)
                : AppColors.filterSurface(context),
            side: BorderSide(
                width: 1.2,
                color: AppColors.addEvent.border(context)
            ),
          ),
          onPressed: () {
            buildTypesBottomSheet(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Text(DataStrings.type),
              Icon(AppIconData.dropList)
            ],
          )
        );
      }
    );
  }

  Future<dynamic> buildTypesBottomSheet(BuildContext context) {
    List<EventType> list = EventType.entries;

    return showModalBottomSheet(
      backgroundColor: AppColors.surface(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.primary(context),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    StringFormatter.colon(DataStrings.type),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.titleLarge,
                        color: AppColors.title(context)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      AddRemoveAllButton(
                        title: ButtonStrings.selectAll,
                        onPressed: () => {
                          controller.addAll()
                        },
                      ),
                      AddRemoveAllButton(
                        title: ButtonStrings.removeAll,
                        onPressed: () => {
                          controller.removeAll()
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            ValuesListView(controller: controller, list: list),
            SizedBox(height: 40,)
          ],
        );
      }
    );
  }
}


class ValuesListView extends StatelessWidget {
  const ValuesListView({
    super.key,
    required this.controller,
    required this.list,
  });

  final FilterController<EventType> controller;
  final List<EventType> list;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.selectedValues,
      builder: (context, selectedList, child) {
        return ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              EventType type = list[index];
              bool isSelected = selectedList.contains(type);
    
              return Column(
                children: [
                  index == 0 ? Divider() : SizedBox.shrink(),
                  InkWell(
                    onTap: () {
                      controller.toggle(type);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isSelected ? AppIconData.selected : AppIconData.notSelected,
                                size: AppSizes.iconSmall,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                type.name,
                                style: AppStyles.basicText(context),
                              ),
                            ],
                          ),
                          Text(
                            isSelected ? MiscStrings.selected : MiscStrings.notSelected,
                            style: AppStyles.noDataText(context),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider()
                ],
              );
            }
        );
      }
    );
  }
}