import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/event_with_options.dart';
import 'package:lustlist/src/domain/entities/filter_data.dart';
import 'package:lustlist/src/domain/entities/filter_query.dart';
import 'package:lustlist/src/domain/entities/numeric_filter_data.dart';
import 'package:lustlist/src/ui/controllers/date_filter_controller.dart';
import 'package:lustlist/src/ui/controllers/numeric_filter_controller.dart';
import 'package:lustlist/src/ui/notifiers/event_notifier.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/controllers/selectable_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/date_filter_buttom.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/events_list.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/filter_group_panel_list.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/int_input_filter_button.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/options_filter_button.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/rating_filter_button.dart';
import 'package:lustlist/src/ui/widgets/add_event_floating_button.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/add_event_pages/add_med_page.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/add_event_pages/add_mstb_page.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/add_event_pages/add_sex_page.dart';


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
  List<CalendarEventWithOptions>? events;

  final _typeFilterController = SelectableFilterController<EventType>(
    allValuesList: EventType.entries,
    selectedValuesList: EventType.entries,
    isEnabledInitially: true
  );

  late final _ratingFilterController = SelectableFilterController<int>(
    allValuesList: ratingValues,
    selectedValuesList: ratingValues,
  );

  final _dateFilterController = DateFilterController();
  final _userOrgasmsFilterController = NumericFilterController();

  SelectableFilterController<Partner>? _partnersFilterController;
  SelectableFilterController<EOption>? _contraceptionFilterController;
  SelectableFilterController<EOption>? _practicesFilterController;
  SelectableFilterController<EOption>? _soloPracticesFilterController;
  SelectableFilterController<EOption>? _posesFilterController;
  SelectableFilterController<EOption>? _placeFilterController;
  SelectableFilterController<EOption>? _ejaculationFilterController;
  SelectableFilterController<EOption>? _complicaciesFilterController;
  SelectableFilterController<EOption>? _stiFilterController;
  SelectableFilterController<EOption>? _obgynFilterController;

  bool get _filtersReady =>
      _partnersFilterController != null &&
      _contraceptionFilterController != null &&
      _practicesFilterController != null &&
      _posesFilterController != null &&
      _placeFilterController != null &&
      _ejaculationFilterController != null &&
      _complicaciesFilterController != null &&
      _obgynFilterController != null &&
      _stiFilterController != null;

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
      final eventsList = await repo.getEventsWithOptionsSortedDescList();
      final partners = await repo.getPartnersSorted(true);

      final contraceptionOptions = await repo.getCategoryOptions("contraception");
      final practicesOptions = await repo.getCategoryOptions("practices");
      final soloPracticesOptions = await repo.getCategoryOptions("solo practices");
      final posesOptions = await repo.getCategoryOptions("poses");
      final placeOptions = await repo.getCategoryOptions("place");
      final ejaculationOptions = await repo.getCategoryOptions("ejaculation");
      final complicaciesOptions = await repo.getCategoryOptions("complicacies");
      final stiOptions = await repo.getCategoryOptions("sti");
      final obgynOptions = await repo.getCategoryOptions("obgyn");

      if (!mounted) return;

      setState(() {
        events = eventsList;

        _partnersFilterController = SelectableFilterController<Partner>(
            allValuesList: partners,
            selectedValuesList: partners
        );
        _contraceptionFilterController = SelectableFilterController<EOption>(
            allValuesList: contraceptionOptions,
            selectedValuesList: contraceptionOptions
        );
        _practicesFilterController = SelectableFilterController<EOption>(
            allValuesList: practicesOptions,
            selectedValuesList: practicesOptions
        );
        _soloPracticesFilterController = SelectableFilterController<EOption>(
            allValuesList: soloPracticesOptions,
            selectedValuesList: practicesOptions
        );
        _posesFilterController = SelectableFilterController<EOption>(
            allValuesList: posesOptions,
            selectedValuesList: posesOptions
        );
        _placeFilterController = SelectableFilterController<EOption>(
            allValuesList: placeOptions,
            selectedValuesList: placeOptions
        );
        _ejaculationFilterController = SelectableFilterController<EOption>(
            allValuesList: ejaculationOptions,
            selectedValuesList: ejaculationOptions
        );
        _complicaciesFilterController = SelectableFilterController<EOption>(
            allValuesList: complicaciesOptions,
            selectedValuesList: complicaciesOptions
        );
        _stiFilterController = SelectableFilterController<EOption>(
            allValuesList: stiOptions,
            selectedValuesList: stiOptions
        );
        _obgynFilterController = SelectableFilterController<EOption>(
            allValuesList: obgynOptions,
            selectedValuesList: obgynOptions
        );

        _isError = false;
        _isLoading = false;
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());

      if (!mounted) return;

      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    //TODO: duration filter
    //TODO: has notes filter
    //TODO: partner's orgasm picker
    //TODO: mstb special options

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
              if (_isError)
                Padding(
                  padding: AppInsets.progressInList,
                  child: ErrorTile(),
                ),
              if ((_isLoading || !_filtersReady) && !_isError)
                Padding(
                  padding: AppInsets.progressInList,
                  child: Center(child: CircularProgressIndicator()),
                ),

              if (!_isLoading && !_isError && _filtersReady)
                AnimatedBuilder(
                  animation: Listenable.merge(filterListenables),
                  builder: (context, _) {
                    List<CalendarEventWithOptions> filteredEvents;
                    final query = buildFilterQuery;
                    filteredEvents = query.filter(events!);

                    bool hasEvents = events!.isNotEmpty;
                    bool hasFilteredEvents = filteredEvents.isNotEmpty;

                    Widget noEventsText = Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Text(
                          MiscStrings.noEvents,
                          style: AppStyles.noDataText(context),
                        ),
                      ),
                    );
                    Widget noFilteredEventsText = Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Text(
                          MiscStrings.noFilteredEvents,
                          style: AppStyles.noDataText(context),
                        ),
                      ),
                    );

                    return ListView(
                      children: [
                        SizedBox(height: 15),
                        SizedBox(
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OptionsFilterButton<EventType>(
                                  title: DataStrings.type,
                                  controller: _typeFilterController,
                                  nameBuilder: (e) => e.name,
                                  canBeDisabled: false,
                                ),
                                OutlinedButton(
                                  onPressed: () => _disableAllFilters(),
                                  style: AppStyles.filterButton(context),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 6,
                                    children: [
                                      Icon(AppIconData.noFilter),
                                      Text(ButtonStrings.disableAllFilters),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DateFilterButton(
                                  controller: _dateFilterController
                                ),
                                RatingFilterButton(
                                  controller: _ratingFilterController
                                ),
                                IntInputFilterButton(
                                  title: DataStrings.myOrgasms,
                                  controller: _userOrgasmsFilterController
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        FilterGroupPanelList(
                          headersList: [
                            DataStrings.sexFilter,
                            DataStrings.mstbFilter,
                            DataStrings.medicalFilter
                          ],
                          expandedBodiesList: [
                            buildFilterList(sexButtonList),
                            buildFilterList(mstbButtonList),
                            buildFilterList(medicalButtonList)
                          ],
                        ),
                        SizedBox(height: 20),
                        if (!hasEvents) noEventsText,
                        if (hasEvents && !hasFilteredEvents) noFilteredEventsText,
                        if (hasEvents && hasFilteredEvents) AllEventsList(list: filteredEvents)
                      ]
                    );
                  }
                ),
              Positioned(
                bottom: 20,
                right: 20,
                child: AddEventFloatingButton(onEventTap: _onAddEventTap)
              ),
            ]),
        bottomNavigationBar: MainBottomNavigationBar(
            context: context,
            currentIndex: HomeNavigationController.pageIndex.value
        )
    );
  }

  Padding buildFilterList(List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: 35,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          itemBuilder: (context, index) => items[index],
          separatorBuilder: (context, int index) => SizedBox(width: 8),
          itemCount: items.length,
        ),
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

  void _disableAllFilters() {
    _typeFilterController.addAll();
    _partnersFilterController!.disable();
    _contraceptionFilterController!.disable();
    _practicesFilterController!.disable();
    _posesFilterController!.disable();
    _placeFilterController!.disable();
    _ejaculationFilterController!.disable();
    _complicaciesFilterController!.disable();
    return;
  }


  List<Listenable?> get filterListenables => [
      _typeFilterController.selectedValues,
      _typeFilterController.enabled,
      _partnersFilterController!.selectedValues,
      _partnersFilterController!.enabled,
      _contraceptionFilterController!.selectedValues,
      _contraceptionFilterController!.enabled,
      _practicesFilterController!.selectedValues,
      _practicesFilterController!.enabled,
      _posesFilterController!.selectedValues,
      _posesFilterController!.enabled,
      _placeFilterController!.selectedValues,
      _placeFilterController!.enabled,
      _ejaculationFilterController!.selectedValues,
      _ejaculationFilterController!.enabled,
      _complicaciesFilterController!.selectedValues,
      _complicaciesFilterController!.enabled,
      _soloPracticesFilterController!.selectedValues,
      _soloPracticesFilterController!.enabled,
      _stiFilterController!.selectedValues,
      _stiFilterController!.enabled,
      _obgynFilterController!.selectedValues,
      _obgynFilterController!.enabled,
      _ratingFilterController.selectedValues,
      _ratingFilterController.enabled,
      _userOrgasmsFilterController.enabled,
      _userOrgasmsFilterController.startNotifier,
      _userOrgasmsFilterController.endNotifier,
    ];

  FilterQuery get buildFilterQuery => FilterQuery(
      types: SelectableFilterData(
        values: _typeFilterController.values,
        isEnabled: _typeFilterController.isEnabled
      ),
      rating: SelectableFilterData(
        isEnabled: _ratingFilterController.isEnabled,
        values: _ratingFilterController.values
      ),
      partners: SelectableFilterData(
        values: _partnersFilterController!.values,
        isEnabled: _partnersFilterController!.isEnabled
      ),
      contraception: SelectableFilterData(
        values: _contraceptionFilterController!.values,
        isEnabled: _contraceptionFilterController!.isEnabled
      ),
      practices: SelectableFilterData(
        values: _practicesFilterController!.values,
        isEnabled: _practicesFilterController!.isEnabled
      ),
      soloPractices: SelectableFilterData(
        values: _soloPracticesFilterController!.values,
        isEnabled: _soloPracticesFilterController!.isEnabled
      ),
      places: SelectableFilterData(
        values: _placeFilterController!.values,
        isEnabled: _placeFilterController!.isEnabled
      ),
      poses: SelectableFilterData(
        values: _posesFilterController!.values,
        isEnabled: _posesFilterController!.isEnabled
      ),
      complicacies: SelectableFilterData(
        isEnabled: _complicaciesFilterController!.isEnabled,
        values: _complicaciesFilterController!.values,
      ),
      ejaculation: SelectableFilterData(
        isEnabled: _ejaculationFilterController!.isEnabled,
        values: _ejaculationFilterController!.values,
      ),
      sti: SelectableFilterData(
        isEnabled: _stiFilterController!.isEnabled,
        values: _stiFilterController!.values,
      ),
      obgyn: SelectableFilterData(
        isEnabled: _obgynFilterController!.isEnabled,
        values: _obgynFilterController!.values,
      ),
      userOrgasms: NumericFilterData(
          isEnabled: _userOrgasmsFilterController.isEnabled,
          start: _userOrgasmsFilterController.start,
          end: _userOrgasmsFilterController.end
      )
    );

  List<OptionsFilterButton> get sexButtonList => [
    OptionsFilterButton<Partner>(
      title: PageTitleStrings.partners,
      controller: _partnersFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.contraception,
      controller: _contraceptionFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.practices,
      controller: _practicesFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.poses,
      controller: _posesFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.place,
      controller: _placeFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.ejaculation,
      controller: _ejaculationFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.complicacies,
      controller: _complicaciesFilterController!,
      nameBuilder: (e) => e.name,
    ),
  ];

  List<OptionsFilterButton> get mstbButtonList => [
    OptionsFilterButton<EOption>(
      title: DataStrings.practices,
      controller: _soloPracticesFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.place,
      controller: _placeFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.complicacies,
      controller: _complicaciesFilterController!,
      nameBuilder: (e) => e.name,
    ),
  ];

  List<OptionsFilterButton> get medicalButtonList => [
    OptionsFilterButton<EOption>(
      title: DataStrings.sti,
      controller: _stiFilterController!,
      nameBuilder: (e) => e.name,
    ),
    OptionsFilterButton<EOption>(
      title: DataStrings.obgyn,
      controller: _obgynFilterController!,
      nameBuilder: (e) => e.name,
    ),
  ];

  List<int> get ratingValues => List.generate(5, (var i) => i + 1);
}