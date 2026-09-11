import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';
import 'package:lustlist/src/ui/notifiers/list_notifier.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/shimmer_options.dart';


class AddCategoryTile extends StatefulWidget {
  final Category category;
  final AddCategoryController controller;
  final IconData iconData;
  final double? iconSize;
  final Widget? body;
  final bool isSoloPractices;

  const AddCategoryTile({
    super.key,
    required this.category,
    required this.controller,
    required this.iconData,
    this.iconSize,
    this.isSoloPractices = false,
    this.body,
  });

  @override
  State<StatefulWidget> createState() => _AddCategoryTileState();

}

class _AddCategoryTileState  extends State<AddCategoryTile> {
  late Future<List<EOption>> _optionsListFuture;
  late EventRepository repo = EventRepository(database);

  ListNotifier<EOption> get _selectedOptions => widget.controller.selectedOptions;
  Category get category => widget.category;
  IconData get iconData => widget.iconData;
  double? get iconSize => widget.iconSize;
  Widget? get body => widget.body;

  late bool anySelectedAtInit = _selectedOptions.value.any(
    (o) => o.categoryId == category.id
        && !["porn", "solo toys"].any((e) => e == o.slug)
  );

  @override
  void initState() {
    super.initState();
    _optionsListFuture = repo.getCategoryOptionsById(
      id: category.id,
      removeMstbSpecial: widget.isSoloPractices
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!category.isVisible && !anySelectedAtInit) return SizedBox.shrink();

    return BasicTile(
      surfaceColor: context.theme.addEventColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringFormatter.colon(category.name),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: context.theme.addEventColors.title,
                  fontSize: context.sizes.titleLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                iconData,
                size: iconSize ?? context.sizes.iconBasic,
                color: context.theme.addEventColors.leadingIcon,
              ),
            ],
          ),
          SizedBox(height: 5),
          body ?? FutureBuilder(
              future: _optionsListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerOptions();
                } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
                  return Text(MiscStrings.errorLoadingData,
                    style: TextStyle(
                      fontSize: context.sizes.textBasic,
                      color: context.theme.addEventColors.coloredText,
                    ),
                  );
                } else {
                  return Center(
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      spacing: 6,
                      children: List.generate(
                          snapshot.data!.length, (index) =>
                          optionListButton(
                              context,
                              snapshot.data![index],
                          )
                      ),
                    ),
                  );
                }
              }
          ),
        ],
      ),
    );
  }


  Widget optionListButton(BuildContext context, EOption option) {
    return AnimatedSize(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOutCirc,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            widget.controller.toggleSelected(option);
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: _selectedOptions.value.contains(option)
              ? context.theme.addEventColors.selectedSurface
              : context.theme.addEventColors.surface,
          side: BorderSide(width: 1.2, color: context.theme.addEventColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _selectedOptions.value.contains(option)
                ? Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  AppIconData.selected,
                  size: context.sizes.iconBasic,
                )) : SizedBox(),
            Text(
              option.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: context.sizes.textBasic,
                color: context.theme.addEventColors.text
              ),
            ),
          ],
        ),
      ),
    );
  }
}