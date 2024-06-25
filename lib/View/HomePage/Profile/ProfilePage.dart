import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Currentmembership.dart'; // Import the CurrentMembershipPage
import 'purchase_page.dart'; // Import the PurchasePage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.isService});
  final bool isService;

  @override
  State createState() => _Profile();
}

class _Profile extends State<ProfilePage> {
  String membershipStatus = 'Basic Member';

  void updateMembershipStatus(String newStatus) {
    setState(() {
      membershipStatus = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.isService
            ? GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(19),
            child: SvgPicture.asset(
              'assets/images/back.svg',
            ),
          ),
        )
            : null,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 0, top: 10, bottom: 15),
              child: ListTile(
                leading: Image.asset('assets/images/profile.png'),
                title: Text(
                  'Akhil Kumar',
                  style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                subtitle: Text(
                  'akhil123@gmail.com',
                  style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(154, 154, 154, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CurrentMembershipPage(),
                    ),
                  );
                },
                child: Stack(children: [
                  SvgPicture.asset(
                    'assets/images/frame.svg',
                    width: 400,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 22),
                        child: Text(
                          'Current Membership',
                          style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, right: 25),
                        child: Text(
                          membershipStatus,
                          style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, right: 25),
                        child: SvgPicture.asset(
                          'assets/images/next.svg',
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'ACCOUNT',
                style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(154, 154, 154, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'BottomNavBar');
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/h1.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Ads Manager',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/d2.svg',
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'Wallet');
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/wallet.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'My Wallet',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/d2.svg',
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'AccountPref');
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/account.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Account Preferences',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/d2.svg',
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'MyAddress');
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/location.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'My Address',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/d2.svg',
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'ReferEarn');
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/earn.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Refer and Earn',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/d2.svg',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'SUPPORT',
                style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(154, 154, 154, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/help.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Help',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/d2.svg',
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/privacy.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Privacy Policy',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/d2.svg',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(50),
              alignment: Alignment.center,
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: const Color.fromRGBO(44, 42, 42, 1)),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Logout',
                style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(44, 42, 42, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
