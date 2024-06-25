import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/order_detail_provider.dart';
import 'package:my_deal_case/Services/DataProvider/services_details_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectTimeScreen extends ConsumerStatefulWidget {
  @override
  _SelectTimeScreenState createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends ConsumerState<SelectTimeScreen> {
  int selectedIndex = 0;

  List allTimes = [
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '12:00 PM',
    '02:00 PM',
    '04:00 PM',
    '06:00 PM',
    '08:00 PM',
    '10:00 PM',
  ];

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    ref
        .read(selectedDateAndTimeProvider.notifier)
        .getTime(allTimes[selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final test = ref.watch(selectedDateAndTimeProvider);
    print(test);

    List<bool> selected = List.generate(
      9,
      (index) {
        if (index == selectedIndex) {
          return true;
        } else {
          return false;
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select Time',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                color: Colors.white,
                elevation: 8, // Add elevation for shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'Select Time',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          TimeButton(
                              text: '08:00 AM',
                              onPressed: () {
                                onTap(0);
                              },
                              isSelected: selected[0]),
                          TimeButton(
                              text: '09:00 AM',
                              onPressed: () {
                                onTap(1);
                              },
                              isSelected: selected[1]),
                          TimeButton(
                              text: '10:00 AM',
                              onPressed: () {
                                onTap(2);
                              },
                              isSelected: selected[2]),
                        ],
                      ),
                      Row(
                        children: [
                          TimeButton(
                            text: '12:00 PM',
                            onPressed: () {
                              onTap(3);
                            },
                            isSelected: selected[3],
                          ),
                          TimeButton(
                              text: '02:00 PM',
                              onPressed: () {
                                onTap(4);
                              },
                              isSelected: selected[4]),
                          TimeButton(
                              text: '04:00 PM',
                              onPressed: () {
                                onTap(5);
                              },
                              isSelected: selected[5]),
                        ],
                      ),
                      Row(
                        children: [
                          TimeButton(
                              text: '06:00 PM',
                              onPressed: () {
                                onTap(6);
                              },
                              isSelected: selected[6]),
                          TimeButton(
                              text: '08:00 PM',
                              onPressed: () {
                                onTap(7);
                              },
                              isSelected: selected[7]),
                          TimeButton(
                              text: '10:00 PM',
                              onPressed: () {
                                onTap(8);
                              },
                              isSelected: selected[8]),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(height: 20, thickness: 1),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Time',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 17,
                          ), // Calendar icon
                          const SizedBox(width: 10),
                          Text(
                            allTimes[selectedIndex],
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          // Time text
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(height: 20, thickness: 1),
                    ],
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
              child: GestureDetector(
                onTap: () {
                  if (selectedIndex == 0) {
                    ref
                        .read(selectedDateAndTimeProvider.notifier)
                        .getTime(allTimes[selectedIndex]);
                  }
                  ref
                      .read(currentOrderProvider.notifier)
                      .getCurrentProductDetails(
                          ref.read(selectedServiceProvider));
                  Navigator.pushNamed(context, "CheckoutScreen");
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
                      'confirm',
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

Widget TimeButton({
  bool isSelected = false,
  VoidCallback? onPressed,
  String text = '',
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? const Color.fromRGBO(232, 80, 91, 1)
                : Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(14),
          color: isSelected
              ? const Color.fromRGBO(255, 206, 199, 1)
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: isSelected
                    ? const Color.fromRGBO(232, 80, 91, 1)
                    : Colors.black),
          ),
        ),
      ),
    ),
  );
}
