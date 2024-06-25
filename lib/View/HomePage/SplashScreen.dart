import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_deal_case/View/AdManager/BottomNavBar.dart';
import 'package:my_deal_case/View/HomePage/BottomNavBar.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/Buy_Sell.dart';
import 'package:my_deal_case/View/HomePage/HomeScreen.dart';
import 'package:my_deal_case/View/OnBoardScreen/onBoardScreen1.dart';
import 'package:my_deal_case/View/RoleScreen/RolePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State createState() => _Splash();
}

class _Splash extends State {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () async {
      checkIsLogin();
    });
  }

  Future<Null> checkIsLogin() async {
    String? userData = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData = prefs.getString("userData");
    print(userData);

    if (userData != null) {
      Map userObj = jsonDecode(userData);
      print("already login.");
      print(userData);
      if (userObj['userType'] == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RolePage(),
          ),
        );
      } else if (userObj["userType"] == "customer") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainBottomNavBar(),
            ));
      } else if (userObj['userType'] == 'manufacturer' ||
          userObj['userType'] == 'service-provider') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainBottomNavBar(),
          ),
        );
      }
      //Navigator.pushNamed(context, 'BuySell');
      //your home page is loaded
    } else {
      //replace it with the login page
      //Navigator.pushNamed(context, 'onBoarding');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnBoardScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/splash.jpeg',
        height: double.infinity,
        width: 250,
      )),
    );
  }
}
