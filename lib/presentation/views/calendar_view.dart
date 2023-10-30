import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:agripure_mobile/models/event_model.dart';
import 'package:agripure_mobile/services/event_service.dart';

DateTime get _now => DateTime.now();
class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);
  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late TextEditingController _eventController;

  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      selectedDay = day;
      today = focusedDay;
    });
  }

  Map<String, List<Event>> events= {};

  List<Event> _getMyEvents(day){
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String formattedDate = dateFormat.format(day);
    return events[formattedDate]?? [];
  }

  @override
  void initState() {
    super.initState();
    selectedDay = today;
    _eventController = TextEditingController();
    events = {};
    EventService.getEvents().then((value) =>{
      events = value,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
      body:  Contend(),
    );
  }

  Widget Contend()
  {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text("CALENDAR OF EVENTS ", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),

            TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
                  rightChevronIcon:Icon(Icons.chevron_right, color: Colors.white)
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                weekendStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              calendarStyle: CalendarStyle(
                markerSize: 8,
                markerDecoration: const BoxDecoration(
                  color: Color.fromRGBO(47, 152, 48, 1.0),
                  shape: BoxShape.circle,),
                defaultTextStyle: const TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                todayTextStyle: const TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                selectedTextStyle: const TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                weekendTextStyle: const TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                todayDecoration: BoxDecoration(
                  color: const Color.fromRGBO(65, 117, 65, 1.0),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color:  Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day)=>isSameDay(day, selectedDay),
              focusedDay: today,
              firstDay: DateTime.utc(2021,05,31),
              lastDay: DateTime.utc(2030, 3, 15),
              onDaySelected: _onDaySelected,
              calendarBuilders: const CalendarBuilders(),
              eventLoader: _getMyEvents,
            ),..._getMyEvents(selectedDay).map(
                (myEvents) => Dismissible(
                    key: Key(myEvents.title),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color:Colors.white),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onDismissed: (direction){
                      setState(() {
                        events[DateFormat("yyyy-MM-dd").format(selectedDay)]?.removeWhere((element) => element.id == myEvents.id);
                        EventService.deleteEvent(myEvents.id);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Card(
                        color: Colors.orange,
                        child: ListTile(
                            leading: const Icon(Icons.done, color: Colors.white,),
                            title: Text(myEvents.title, style: const TextStyle(color: Colors.white),)
                        ),
                      ),
                    ),
                )
              ),
          ],
        ),
    );

  }
}