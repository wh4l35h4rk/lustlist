import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/ui/controllers/selectable_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/add_remove_all_button.dart';
import 'package:lustlist/src/core/widgets/droplist_button.dart';

class ListFilterButton<T> extends StatelessWidget {
  const ListFilterButton({
    required this.title,
    required this.controller,
    required this.valueWidgetBuilder,
    this.canBeDisabled = true,
    super.key,
  });

  final String title;
  final SelectableFilterController<T> controller;
  final Widget Function(T value) valueWidgetBuilder;
  final bool canBeDisabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          controller.selectedValues,
          controller.enabled,
        ]),
        builder: (context, _) {
          bool changesApplied = canBeDisabled
              ? controller.isEnabled
              : !controller.allSelected();

          return DroplistButton(
            title: title,
            backgroundColor: changesApplied
                ? AppColors.filterSurface(context)
                : AppColors.surface(context),
            onPressed: () {
              buildValuesBottomSheet(context);
            },
          );
        }
    );
  }

  Future<dynamic> buildValuesBottomSheet(BuildContext context) {
    List<T> list = controller.allValues;

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
              SizedBox(height: 15,),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 8
                          ),
                          child: Text(
                            StringFormatter.colon(title),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.titleLarge,
                                color: AppColors.title(context)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (canBeDisabled) ValueListenableBuilder(
                              valueListenable: controller.enabled,
                              builder: (context, value, child) {
                                return AddRemoveAllButton(
                                  title: ButtonStrings.filter,
                                  onPressed: () => {
                                    controller.toggleEnabled()
                                  },
                                  backgroundColor: controller.isEnabled
                                      ? AppColors.filterButton(context)
                                      : AppColors.surface(context),
                                  icon: Icon(controller.isEnabled
                                      ? AppIconData.selected
                                      : AppIconData.notSelected
                                  ),
                                );
                              }
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _ValuesListView<T>(
                controller: controller,
                list: list,
                valueWidget: valueWidgetBuilder,
              ),
              SizedBox(height: 40,)
            ],
          );
        }
    );
  }
}


class _ValuesListView<T> extends StatelessWidget {
  const _ValuesListView({
    required this.controller,
    required this.list,
    required this.valueWidget,
  });

  final SelectableFilterController<T> controller;
  final List<T> list;
  final Widget Function(T value) valueWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          controller.selectedValues,
          controller.enabled,
        ]),
        builder: (context, _) {
          var selectedList = controller.selectedValues.value;
          var isEnabled = controller.isEnabled;

          return Expanded(
            child: ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  T value = list[index];
                  bool isSelected = selectedList.contains(value);

                  return Column(
                    children: [
                      index == 0 ? Divider() : SizedBox.shrink(),
                      InkWell(
                        onTap: () {
                          controller.toggle(value);
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
                                    getTileIconData(isEnabled, isSelected),
                                    size: AppSizes.iconSmall,
                                  ),
                                  const SizedBox(width: 12),
                                  valueWidget(value),
                                ],
                              ),
                              Text(
                                getTileStatus(isEnabled, isSelected),
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
            ),
          );
        }
    );
  }

  String getTileStatus(bool isFilterEnabled, bool isSelected) {
    if (!isFilterEnabled) return MiscStrings.filterDisabled;
    return isSelected ? MiscStrings.selected : MiscStrings.notSelected;
  }

  IconData getTileIconData(bool isFilterEnabled, bool isSelected) {
    if (!isFilterEnabled) return AppIconData.unknownGender;
    return isSelected ? AppIconData.selected : AppIconData.notSelected;
  }
}