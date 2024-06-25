import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/OtpServices/otpservice.dart';
import 'package:my_deal_case/View/HomePage/BottomNavBar.dart';
import 'package:my_deal_case/View/LoginPage/otpScreen.dart';

class ShowDailogPage extends StatefulWidget {
  const ShowDailogPage({super.key});
  @override
  State createState() => _ShowDialogState();
}

class _ShowDialogState extends State {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (isOtpFilled) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainBottomNavBar(),
            ));
      } else {
        Navigator.pushReplacementNamed(context, 'SelectRole');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Container(
          height: 162,
          width: 300,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/Verify.svg',
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 40),
              Text(
                'You have been successfully verified',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
