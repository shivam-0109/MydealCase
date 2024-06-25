import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderProceedPage extends StatefulWidget {
  const UnderProceedPage({super.key});
  @override
  State createState() => _Photo();
}

class _Photo extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/p4.svg',
                height: 300,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 70, left: 70, top: 15),
              child: Text(
                textAlign: TextAlign.center,
                'Your account has been has been successfully verified!',
                style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 10),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: InkWell(
          onTap: () {
            //  getImage();
            Navigator.pushNamed(context, 'Rejected');
          },
          child: Container(
            alignment: Alignment.center,
            height: 45,
            width: 290,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(44, 42, 42, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              textAlign: TextAlign.center,
              'Proceed',
              style: GoogleFonts.montserrat(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
