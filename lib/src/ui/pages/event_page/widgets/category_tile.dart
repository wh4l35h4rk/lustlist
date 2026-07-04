import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/domain/repository.dart';


class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.event,
    required this.title,
    required this.categorySlug,
    required this.iconData,
    this.iconSize = AppSizes.iconBasic,
    this.onNoResultsText = MiscStrings.notStated,
    this.removeMstbSpecial = false
  });

  final CalendarEvent event;
  final String title;
  final String categorySlug;
  final IconData iconData;
  final double iconSize;
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
              return buildTile(
                Text(
                  MiscStrings.errorLoadingData,
                  style: TextStyle(
                    color: CategoryTileColors.text(context),
                    fontSize: AppSizes.titleSmall,
                  ),
                ),
                const ValueKey('error'),
                context,
              );
            }

            if (!snapshot.hasData) {
              return const SizedBox(
                key: ValueKey('empty'),
              );
            }

            return buildTile(
              snapshot.data!,
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
        surfaceColor: CategoryTileColors.surface(context),
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
                    color: CategoryTileColors.title(context),
                    fontSize: AppSizes.titleLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  iconData,
                  size: iconSize,
                  color: CategoryTileColors.leadingIcon(context),
                ),
              ],
            ),
            SizedBox(height: 5),
            child
          ],
        ),
      );
  }


  Future<Widget?> _getOptions(AppDatabase db, context) async {
    EventRepository repo = EventRepository(db);
    List<EOption> options = await repo.getEventCategoryOptions(
      eventId: event.event.id,
      categorySlug: categorySlug,
      removeMstbSpecial: true
    );

    if (options.isEmpty){
      return null;
    } else {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [for (var option in options)
          Container(
            padding: AppInsets.optionsContainer,
            decoration: BoxDecoration(
              border: Border.all(
                color: CategoryTileColors.border(context),
              ),
              borderRadius: BorderRadius.circular(AppSizes.containerTileRadius),
            ),
            child: Text(option.name),
          ),
        ],
      );
    }
  }
}

