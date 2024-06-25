import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPrefPage extends StatefulWidget {
  const AccountPrefPage({super.key});
  @override
  State createState() => _AccountPrefPage();
}

class _AccountPrefPage extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(19),
            child: SvgPicture.asset(
              'assets/images/back.svg',
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Account Preferences',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '');
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Notification Settings',
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
              Navigator.pushNamed(context, '');
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Change Mobile Number',
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: Color.fromRGBO(242, 242, 242, 1),
              thickness: 4,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '');
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Deactivate Account',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }
}
