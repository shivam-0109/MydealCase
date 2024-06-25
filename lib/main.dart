import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/View/HomePage/ProductDetails/ProductDetailsBuySell.dart';
import 'package:my_deal_case/View/AdManager/BottomNavBar.dart';
import 'package:my_deal_case/View/AdManager/InventoryScreen.dart';
import 'package:my_deal_case/View/HomePage/OffersPage/ApplyCoupon.dart';
import 'package:my_deal_case/View/HomePage/BottomNavBar.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/Buy_Sell.dart';
import 'package:my_deal_case/View/HomePage/chatPage/ChatScreen.dart';
import 'package:my_deal_case/View/HomePage/checkOutpage/CheckOutScreen.dart';
import 'package:my_deal_case/View/HomePage/checkOutpage/CheckoutFlow.dart';
import 'package:my_deal_case/View/HomePage/FavPage.dart/FavPage.dart';
import 'package:my_deal_case/View/HomePage/Profile/GoogleMapPage.dart';
import 'package:my_deal_case/View/HomePage/HomeService/Homeservice.dart';
import 'package:my_deal_case/View/HomePage/HomeService/RepairServiceman.dart';
import 'package:my_deal_case/View/HomePage/HomeService/SelectTime.dart';
import 'package:my_deal_case/View/HomePage/MprKyc/RejectPage.dart';
import 'package:my_deal_case/View/HomePage/MprKyc/UnderProceedPage.dart';
import 'package:my_deal_case/View/HomePage/MprKyc/UploadDocPage.dart';
import 'package:my_deal_case/View/HomePage/MprKyc/UnderVerifyPage.dart';
import 'package:my_deal_case/View/HomePage/OffersPage/OffersPage.dart';
import 'package:my_deal_case/View/HomePage/checkOutpage/Payment.dart';
import 'package:my_deal_case/View/HomePage/Profile/AccountPrefPage.dart';
import 'package:my_deal_case/View/HomePage/Profile/Add_address.dart';
import 'package:my_deal_case/View/HomePage/Profile/AdsManagerPage.dart';
import 'package:my_deal_case/View/HomePage/Profile/CurrentMemberPage.dart';
import 'package:my_deal_case/View/HomePage/Profile/MyAddressPage.dart';
import 'package:my_deal_case/View/HomePage/Profile/ProfilePage.dart';
import 'package:my_deal_case/View/HomePage/Profile/ReferEarnPage.dart';
import 'package:my_deal_case/View/HomePage/Rentalpage/Rental.dart';
import 'package:my_deal_case/View/HomePage/searchBarPage/SearchBarPage.dart';
import 'package:my_deal_case/View/HomePage/servicesPage/Services.dart';
import 'package:my_deal_case/View/HomePage/SmsPage/SmsPage.dart';
import 'package:my_deal_case/View/HomePage/SplashScreen.dart';
import 'package:my_deal_case/View/HomePage/Profile/WalletPage.dart';
import 'package:my_deal_case/View/LoginPage/CreatePage.dart';
import 'package:my_deal_case/View/LoginPage/LoginPage.dart';
import 'package:my_deal_case/View/LoginPage/otpScreen.dart';
import 'package:my_deal_case/View/OnBoardScreen/onBoardScreen1.dart';
import 'package:my_deal_case/View/RoleScreen/RolePage.dart';
import 'package:my_deal_case/View/ShowDialogPage.dart';

import 'View/HomePage/HomeService/SelectDate.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'onBoard',
      routes: {
        'Login': (context) => const LoginPage(),
        'OTP': (context) => const OtpScreen(),
        'Verify': (context) => const ShowDailogPage(),
        'Create': (context) => const CreatePage(),
        'SelectRole': (context) => const RolePage(),
        'BuySell': (context) => const BuySell(),
        'Services': (context) => const ServicesPage(),
        'Rental': (context) => const RentalPage(),
        'onBoarding': (context) => const OnBoardScreen(),
        'ProductDetails': (context) => const ProductDetailsBuySell(),
        'searchBar': (context) => const SearchBarPage(),
        'profile': (context) => const ProfilePage(
              isService: false,
            ),
        'OffersPage': (context) => const OffersPage(),
        'FavPage': (context) => const FavPage(),
        'SMSPage': (context) => const SmsPage(),
        'CurrentMembership': (context) => const MembershipPage(),
        'AdsManager': (context) => const AdsManagerPage(),
        'Wallet': (context) => const WalletPage(),
        'AccountPref': (context) => const AccountPrefPage(),
        'MyAddress': (context) => const MyAddressPage(),
        'ReferEarn': (context) => const ReferEarnPage(),
        'GoogleMap': (context) => const GoogleMapPage(),
        'AddAddress': (context) => const AddAddress(),
        'UploadDoc': (context) => const UploadDocPage(),
        'UnderVerify': (context) => const UnderVerifyPage(),
        'UnderProceed': (context) => const UnderProceedPage(),
        'Rejected': (context) => const RejectedPage(),
        'ChatScreen': (context) => const ChatScreen(),
        'BottomNavBar': (context) => BottomNavBar(),
        'CheckoutScreen': (context) => CheckoutScreen(),
        'Payment': (context) => Payment(),
        'CheckoutFlow': (context) => Checkoutflow(),
        'ApplyCoupon': (context) => ApplyCoupon(),
        'HomeServiceScreen': (context) => HomeServiceScreen(),
        'SelectDateScreen': (context) => SelectDateScreen(),
        'SelectTimeScreen': (context) => SelectTimeScreen(),
        'RepairServiceScreen': (context) => RepairServiceScreen(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
