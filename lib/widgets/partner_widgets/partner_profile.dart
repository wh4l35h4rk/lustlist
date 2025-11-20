import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/widgets/calendar_widgets/event_listtile.dart';
import 'package:lustlist/widgets/event_widgets/notes_tile.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:lustlist/repository/calendar_event.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/widgets/partner_widgets/partner_data_tile.dart';
import '../../controllers/home_navigation_controller.dart';
import '../../main.dart';
import '../../pages/eventpage.dart';
import '../../repository/repository.dart';


class PartnerProfile extends StatefulWidget {
  const PartnerProfile({
    required this.partner,
    super.key
  });

  final Partner partner;

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
              //TODO: edit partner page
              // final result = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => _getEditPartnerWidget(partner)
              //   ),
              // );
              // if (result == true) {
              //   partnerChanged = true;
              //   await Future.delayed(Duration(milliseconds: 100));
              //   await reloadPartner(database);
              //   setState(() {});
              // }
            },
            icon: Icon(Icons.edit),
            color: AppColors.appBar.icon(context),
          ),
          deleteButton: IconButton(
            onPressed: () => _showPopUp(context),
            icon: Icon(Icons.delete),
            color: AppColors.appBar.icon(context),
          ),
        ),
        body: ListView(
          children: [
            PartnerDataTile(
              partner: partner,
            ),
            NotesTile(partner: partner,),
            SizedBox(height: 20,),
            FutureBuilder(
              future: partnerEventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      const SizedBox(height: 80,),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                      child: Text(
                        "Error loading data.",
                        style: TextStyle(
                          color: AppColors.categoryTile.text(context),
                        ),
                      )
                  );
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
                              fontSize: 25,
                              color: AppColors.categoryTile.title(context)
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(
                            Icons.favorite_border,
                            color: AppColors.categoryTile.leadingIcon(context),
                            size: 25,
                          )
                        ]
                      ),
                    ),
                    events.isEmpty
                      ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 3),
                        child: Text(
                            "No activities together!",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: AppColors.defaultTile(context)
                            ),
                          ),
                      )
                      : SizedBox.shrink(),
                    ListView.builder(
                        itemCount: events.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          CalendarEvent event = events[index];
                          return Column(
                            children: [
                              EventListTile(
                                event: event,
                                partnerOrgasms: event.partnersMap?[partner],
                                onTap: () => _onEventListTileTap(event),
                              ),
                              index != events.length - 1 ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Divider(
                                    height: 0
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


  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap:() {
            Navigator.of(context).pop();
          },
          child: AlertDialog(
            content: Text(
              "Are you sure you want to delete this partner? All events with this partner will be deleted, too. This action can't be undone.",
              style: TextStyle(fontSize: 15, ),
              textAlign: TextAlign.justify,
            ),
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text("Return to partner"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                onPressed: () {
                  deletePartner(partner);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(true);
                },
                color: AppColors.appBar.surface(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Delete",
                  style: TextStyle(color: AppColors.appBar.text(context)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<void> reloadPartner(AppDatabase db) async {
    Partner partnerNew = await db.getPartnerById(partner.id);
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
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(event: event),
      ),
    );
    if (result == true) {
      partnerChanged = true;
      partnerEventsFuture = _loadPartnerEvents(database);
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {});
    }
  }
}