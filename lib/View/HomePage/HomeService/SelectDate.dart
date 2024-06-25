import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/services_details_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateScreen extends ConsumerStatefulWidget {
  @override
  _SelectDateScreenState createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends ConsumerState<SelectDateScreen> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select Date',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 4, // Add elevation for shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TableCalendar<DateTime>(
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2040),
                  focusedDay: selectedDay,
                  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                  onDaySelected: (selectedDate, focusedDay) {
                    setState(() {
                      selectedDay = selectedDate;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                        color: Color.fromRGBO(234, 134, 141, 1.0),
                        shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(
                      color: Color.fromRGBO(232, 80, 91, 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    headerPadding: const EdgeInsets.symmetric(vertical: 10),
                    titleTextStyle: const TextStyle(
                      color: Color.fromRGBO(232, 80, 91, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    formatButtonDecoration: BoxDecoration(
                      color: const Color.fromRGBO(
                          232, 80, 91, 1), // Red background for format button
                      borderRadius: BorderRadius.circular(20),
                    ),
                    formatButtonTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color.fromRGBO(144, 144, 144, 1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(selectedDateAndTimeProvider.notifier)
                      .getDate(selectedDay.toString());
                  Navigator.pushNamed(context, 'SelectTimeScreen');
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8, left: 20, right: 20, top: 8),
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromRGBO(44, 42, 42, 1),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
