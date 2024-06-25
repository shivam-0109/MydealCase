import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_deal_case/View/AdManager/DiscountFlowScreen.dart';
import 'package:my_deal_case/View/AdManager/InventoryScreen.dart';
import 'package:my_deal_case/View/AdManager/MyAds.dart';
import 'package:my_deal_case/View/AdManager/OverviewScreen.dart';
import 'package:my_deal_case/View/AdManager/ProductList.dart';
import 'package:my_deal_case/View/HomePage/Profile/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  Map<String, dynamic> userDetails = {};

  @override
  void initState() {
    loadUserDetails();
    super.initState();
  }

  void loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    userDetails = json.decode(prefs.getString("userData")!);
    setState(() {});
  }

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      OverviewScreen(),
      ProductList(),
      const Center(
        child: Text(" add screen"),
      ),
      MyAdsScreen(
        userDetails: userDetails,
      ),
      const ProfilePage(
        isService: true,
      ),
    ];
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
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: currentIndex == 0
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.grey),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket,
                  color: currentIndex == 1
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.grey),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 50,
                height: 50,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DiscountFlowScreen()));
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.2),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          color: Color.fromRGBO(232, 80, 91, 1),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt,
                  color: currentIndex == 3
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.grey),
              label: 'My Ads',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: currentIndex == 4
                      ? const Color.fromRGBO(232, 80, 91, 1)
                      : Colors.grey),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
