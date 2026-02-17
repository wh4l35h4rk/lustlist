import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/ui/widgets/event_listtile.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/ui/widgets/notes_tile.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/pages/partners_page/widgets/partner_data_tile.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/edit_partner_page.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/ui/pages/event_page/eventpage.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/config/constants/layout.dart';


class PartnerProfile extends StatefulWidget {
  const PartnerProfile({
    required this.partner,
    this.previousEventId,
    super.key,
  });

  final Partner partner;
  final int? previousEventId;

  @override
  State<PartnerProfile> createState() => _PartnerProfileState();
}

class _PartnerProfileState extends State<PartnerProfile> {
  final repo = EventRepository(database);
  late Partner partner;
  late Future<List<CalendarEvent>> partnerEventsFuture;
  bool partnerChanged = false;

  @override
  void initState() {
    super.initState();
    partner = widget.partner;
    partnerEventsFuture = _loadPartnerEvents(database);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          title: partner.name,
          backButton: IconButton(
            onPressed: () => Navigator.of(context).pop(partnerChanged ? true : null),
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.appBar.icon(context),
          ),
          editButton: IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPartnerPage(partner: partner)
                ),
              );
              if (result == true) {
                partnerChanged = true;
                await reloadPartner(database);
                await Future.delayed(Duration(milliseconds: futureDelay));
                setState(() {});
              }
            },
            icon: Icon(Icons.edit),
            color: AppColors.appBar.icon(context),
          ),
          deleteButton: FutureBuilder(
            future: partnerEventsFuture,
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.hasError || !snapshot.hasData) {
                return SizedBox.shrink();
              }
              List<CalendarEvent> events = snapshot.data!;
              
              return IconButton(
                onPressed: () => _showPopUp(context, events.isNotEmpty),
                icon: Icon(Icons.delete),
                color: AppColors.appBar.icon(context),
              );
            }
          ),
        ),
        body: ListView(
          children: [
            PartnerDataTile(
              partner: partner,
            ),
            NotesTile(partner: partner),
            SizedBox(height: 20),
            FutureBuilder(
              future: partnerEventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: AppInsets.progressInList,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return ErrorTile();
                }

                List<CalendarEvent> events = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            events.length.toString(),
                            style: TextStyle(
                              fontSize: AppSizes.eventCounter,
                              color: AppColors.categoryTile.title(context)
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(
                            Icons.favorite_border,
                            color: AppColors.categoryTile.leadingIcon(context),
                            size: AppSizes.eventCounter,
                          )
                        ]
                      ),
                    ),
                    events.isEmpty
                      ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 3),
                        child: Text(
                            MiscStrings.noPartnerEvents,
                            style: AppStyles.noDataText(context)
                          ),
                      )
                      : SizedBox.shrink(),
                    ListView.builder(
                      itemCount: events.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var event = events[index];

                        IconData partnerIcon;
                        if (event.partnersMap != null && event.partnersMap!.length > 1) {
                          partnerIcon = CategoryIcons.two;
                        } else {
                          partnerIcon = Icons.favorite;
                        }

                        return Column(
                          children: [
                            EventListTile(
                              event: event,
                              partnerOrgasms: event.partnersMap?[partner],
                              partneredIcon: partnerIcon,
                              fromPartnerProfile: true,
                              onTap: () => _onEventListTileTap(event),
                            ),
                            index != events.length - 1 ? Padding(
                              padding: AppInsets.divider,
                              child: Divider(
                                height: AppSizes.dividerMinimal,
                              ),
                            ) : SizedBox.shrink(),
                          ],
                        );
                      }
                    ),
                  ],
                );
              }
            )
          ],
        ),
        bottomNavigationBar: MainBottomNavigationBar(
            context: context,
            currentIndex: HomeNavigationController.pageIndex.value
        )
    );
  }


  Future<void> deletePartner(Partner partner) async {
    await database.deletePartner(partner.id);
  }


  void _showPopUp(BuildContext context, bool hasEvents) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap:() {
            Navigator.of(context).pop();
          },
          child: AlertDialog(
            content: Text(
              hasEvents ? AlertStrings.noDeletePartner : AlertStrings.deletePartner,
              style: TextStyle(fontSize: AppSizes.alertBody),
              textAlign: TextAlign.justify,
            ),
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.alertButtonRadius),
                ),
                child: const Text(
                  ButtonStrings.partnerReturn,
                  style: TextStyle(fontSize: AppSizes.alertButtonText),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              !hasEvents
                ? MaterialButton(
                  onPressed: () {
                    deletePartner(partner);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(true);
                    eventsUpdated.notifyUpdate();
                  },
                  color: AppColors.appBar.surface(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.alertButtonRadius),
                  ),
                  child: Text(
                    ButtonStrings.delete,
                    style: TextStyle(
                        fontSize: AppSizes.alertButtonText,
                        color: AppColors.appBar.text(context)
                    ),
                  ),
                )
                : SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }


  Future<void> reloadPartner(AppDatabase db) async {
    Partner partnerNew = await db.getPartnerById(partner.id);
    partnerEventsFuture = _loadPartnerEvents(database);
    partner = partnerNew;
  }


  Future<List<CalendarEvent>> _loadPartnerEvents(AppDatabase db) async {
    List<Event> dbEvents = await db.getEventsByPartnerId(partner.id);
    List<CalendarEvent> calendarEvents = [];
    for (Event e in dbEvents) {
      var calendarEvent = await repo.dbToCalendarEvent(e);
      calendarEvents.add(calendarEvent);
    }
    calendarEvents.sort((a, b) => repo.sortDateTime(a.event, b.event));
    return calendarEvents;
  }


  Future<void> _onEventListTileTap(CalendarEvent event) async {
    if (widget.previousEventId == event.event.id) {
      Navigator.of(context).pop(partnerChanged ? true : null);
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(event: event),
      ),
    );
    if (result == true) {
      partnerChanged = true;
      partnerEventsFuture = _loadPartnerEvents(database);
      await Future.delayed(Duration(milliseconds: futureDelay));
      setState(() {});
    }
  }
}