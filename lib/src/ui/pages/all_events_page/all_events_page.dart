import 'package:flutter/material.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/controllers/filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/add_remove_all_button.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/events_list.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/selectable_value_button.dart';
import 'package:lustlist/src/ui/widgets/add_event_floating_button.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/add_event_pages/add_med_page.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/add_event_pages/add_mstb_page.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/add_event_pages/add_sex_page.dart';
import 'package:lustlist/src/ui/pages/event_page/eventpage.dart';


class AllEventsPage extends StatefulWidget {
  const AllEventsPage({
    super.key
  });

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}


class _AllEventsPageState extends State<AllEventsPage> {
  bool _isLoading = true;
  bool _isError = false;
  List<CalendarEvent>? events;

  List<EOption>? contraceptionOptions;

  final _typeFilterController = FilterController<EventType>(selectedValuesList: EventType.entries);

  @override
  void initState() {
    super.initState();
    _loadData();
    eventsUpdated.addListener(_onEventsUpdated);
  }

  @override
  void dispose() {
    eventsUpdated.removeListener(_onEventsUpdated);
    super.dispose();
  }

  void _onEventsUpdated() async {
    await Future.delayed(Duration(milliseconds: futureDelay));
    await _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      final repo = EventRepository(database);
      final eventsList = await repo.getEventsSortedDescList();

      setState(() {
        events = eventsList;
        _isLoading = false;
        _isError = false;
      });
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          title: PageTitleStrings.allEvents,
          backButton: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(AppIconData.arrowLeft),
            color: AppColors.appBar.icon(context),
          ),
        ),
        body: Stack(
            children: [
              if (_isLoading)
                Padding(
                  padding: AppInsets.progressInList,
                  child: Center(child: CircularProgressIndicator()),
              ),
              if (_isError)
                Padding(
                  padding: AppInsets.progressInList,
                  child: ErrorTile(),
              ),
              if (!_isLoading && !_isError)
                ValueListenableBuilder(
                  valueListenable: _typeFilterController.selectedValues,
                  builder: (context, value, child) {
                    List<CalendarEvent> filteredEvents;
                    if (value.isEmpty) {
                      filteredEvents = [];
                    } else {
                      filteredEvents = events!
                        .where((e) => value.any((t) => t == e.type))
                        .toList();
                    }

                    return Column(
                      children: [
                        SizedBox(height: 6,),
                        BasicTile(
                          surfaceColor: AppColors.filterSurface(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    StringFormatter.colon(DataStrings.types),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.categoryTile.title(context),
                                      fontSize: AppSizes.titleLarge,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.category,
                                    size: AppSizes.iconBasic,
                                    color: AppColors.categoryTile.leadingIcon(context),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AddRemoveAllButton(
                                      title: ButtonStrings.selectAll,
                                      onPressed: () => {
                                        _typeFilterController.addAll(EventType.entries)
                                      },
                                    ),
                                    AddRemoveAllButton(
                                      title: ButtonStrings.removeAll,
                                      onPressed: () => {
                                        _typeFilterController.removeAll()
                                      },
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: typeButtonList(context)
                              ),
                            ]
                          )
                        ),
                        SizedBox(height: 10,),
                        AllEventsList(list: filteredEvents)
                      ]
                    );
                  }
                ),
              Positioned(
                bottom: 20,
                right: 20,
                child: AddEventFloatingButton(onEventTap: _onAddEventTap)
              )
            ]),
        bottomNavigationBar: MainBottomNavigationBar(
            context: context,
            currentIndex: HomeNavigationController.pageIndex.value
        )
    );
  }


  Widget typeButtonList(BuildContext context) {
    List<Widget> buttonList = List.generate(
      EventType.entries.length,
        (index) => SelectableValueButton(
          controller: _typeFilterController, 
          value: EventType.entries[index], 
          title: EventType.entries[index].name
        )
    );

    return Scrollbar(
      thickness: 1,
      radius: Radius.circular(20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: buttonList
      ),
    );
  }

  Future<void> _onAddEventTap(int index) async {
    StatefulWidget widget;
    if (index == 0) {
      widget = AddSexEventPage();
    } else if (index == 1) {
      widget = AddMstbEventPage();
    } else {
      widget = AddMedEventPage();
    }

    await Navigator.push(context,
      MaterialPageRoute(builder: (_) => widget),
    );
  }
}