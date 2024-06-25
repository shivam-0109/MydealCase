import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UnderVerifyPage extends StatefulWidget {
  const UnderVerifyPage({super.key});
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
                'assets/images/p2.svg',
                height: 300,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 65, left: 65, top: 15),
              child: Text(
                textAlign: TextAlign.center,
                'Your account is under review and we will notify you once your account is verified',
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
            exit(0);
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
              'Close',
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
