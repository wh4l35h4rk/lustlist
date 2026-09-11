import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.event,
    required this.title,
    required this.categorySlug,
    required this.iconData,
    this.iconSize,
    this.onNoResultsText = MiscStrings.notStated,
    this.removeMstbSpecial = false
  });

  final CalendarEvent event;
  final String title;
  final String categorySlug;
  final IconData iconData;
  final double? iconSize;
  final String onNoResultsText;
  final bool removeMstbSpecial;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getOptions(database, context),
      builder: (context, snapshot) {
        bool isLoading = snapshot.connectionState == ConnectionState.waiting;
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          },
          child: () {
            if (isLoading) {
              return const SizedBox(
                key: ValueKey('empty'),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return buildTile(
                ErrorTile(),
                const ValueKey('error'),
                context,
              );
            }
            if (!snapshot.hasData) {
              return const SizedBox(
                key: ValueKey('empty'),
              );
            }

            Widget optionTiles = _buildOptions(snapshot.data!, context);
            return buildTile(
              optionTiles,
              const ValueKey('data'),
              context,
            );
          }(),
        );
      }
    );
  }


  BasicTile buildTile(Widget child, Key key, BuildContext context) {
    return BasicTile(
        key: key,
        surfaceColor: context.theme.categoryTileColors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: context.theme.categoryTileColors.title,
                    fontSize: context.sizes.titleLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  iconData,
                  size: iconSize ?? context.sizes.iconBasic,
                  color: context.theme.categoryTileColors.leadingIcon,
                ),
              ],
            ),
            SizedBox(height: 5),
            child
          ],
        ),
      );
  }


  Future<List<EOption>?> _getOptions(AppDatabase db, BuildContext context) async {
    EventRepository repo = EventRepository(db);
    List<EOption> options = await repo.getEventCategoryOptions(
      eventId: event.event.id,
      categorySlug: categorySlug,
      removeMstbSpecial: true
    );

    if (options.isEmpty){
      return null;
    } else {
      return options;
    }
  }


  Widget _buildOptions(List<EOption> options, BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [for (var option in options)
        Container(
          padding: AppInsets.optionsContainer,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.categoryTileColors.border,
            ),
            borderRadius: BorderRadius.circular(context.sizes.containerTileRadius),
          ),
          child: Text(
            option.name,
            style: TextStyle(fontSize: context.sizes.textBasic),
          ),
        ),
      ],
    );
  }
}

