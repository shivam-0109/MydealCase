import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_deal_case/View/AdManager/DiscountFlowScreen.dart';
import 'package:my_deal_case/View/AdManager/InventoryScreen.dart';
import 'package:my_deal_case/View/AdManager/MyAds.dart';
import 'package:my_deal_case/View/AdManager/OverviewScreen.dart';
import 'package:my_deal_case/View/AdManager/ProductList.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/Buy_Sell.dart';
import 'package:my_deal_case/View/HomePage/chatPage/ChatScreen.dart';
import 'package:my_deal_case/View/HomePage/FavPage.dart/FavPage.dart';
import 'package:my_deal_case/View/HomePage/HomeScreen.dart';
import 'package:my_deal_case/View/HomePage/OffersPage/OffersPage.dart';
import 'package:my_deal_case/View/HomePage/Profile/ProfilePage.dart';
import 'package:my_deal_case/View/HomePage/Rentalpage/Rental.dart';
import 'package:my_deal_case/View/HomePage/servicesPage/Services.dart';
import 'package:my_deal_case/View/HomePage/SmsPage/SmsPage.dart';

class MainBottomNavBar extends StatefulWidget {
  @override
  _MainBottomNavBarState createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _page = 0;

  List<Widget> pages = [
    HomeScreen(),
    OffersPage(),
    FavPage(),
    SmsPage(),
    ProfilePage(
      isService: false,
    ),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _page,
        onTap: updatePage,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: Color.fromRGBO(232, 80, 91, 1),
          unselectedItemColor: Colors.black,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/images/home.svg', // Replace 'your_icon.svg' with your SVG file path
                  color: currentIndex == 0
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.black,
                  width: 24, // Adjust width as needed
                  height: 24, // Adjust height as needed
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/images/offers.svg', // Replace 'your_icon.svg' with your SVG file path
                  color: currentIndex == 1
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.black,
                  width: 24, // Adjust width as needed
                  height: 24, // Adjust height as needed
                ),
              ),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/images/fav.svg', // Replace 'your_icon.svg' with your SVG file path
                  color: currentIndex == 2
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.black,
                  width: 24, // Adjust width as needed
                  height: 24, // Adjust height as needed
                ),
              ),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/images/sms.svg', // Replace 'your_icon.svg' with your SVG file path
                  color: currentIndex == 3
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.black,
                  width: 24, // Adjust width as needed
                  height: 24, // Adjust height as needed
                ),
              ),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/images/profile.svg', // Replace 'your_icon.svg' with your SVG file path
                  color: currentIndex == 4
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.black,
                  width: 24, // Adjust width as needed
                  height: 24, // Adjust height as needed
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
