import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/OtpServices/otpservice.dart';
import 'package:my_deal_case/View/LoginPage/CreatePage.dart';
import 'package:my_deal_case/View/LoginPage/LoginPage.dart';
import 'package:pinput/pinput.dart';

final TextEditingController otpController = TextEditingController();
bool isOtpFilled = false;

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(5, 14, 23, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Enter The OTP',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Pinput(
                controller: otpController,
                onChanged: (value) {
                  setState(() {
                    isOtpFilled = value.isNotEmpty;
                  });
                },
                validator: (s) {
                  log(s.toString());
                  return s == otpController.text ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => (pin),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '+91 ${numController.text.isNotEmpty ? numController.text : userMobController.text}',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (numController.text.isNotEmpty) {
                        Navigator.pushNamed(context, 'Login');
                      }
                    },
                    icon: Icon(
                      Icons.edit,
                      color: numController.text.isNotEmpty
                          ? const Color.fromRGBO(232, 80, 91, 1)
                          : const Color.fromRGBO(137, 137, 137, 1),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 30, top: 20),
              child: Text(
                'By logging in you are agreeing to Heartcare+ Terms of Service and Privacy Policy',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(137, 137, 137, 1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (isOtpFilled)
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 40, bottom: 25),
                child: GestureDetector(
                  onTap: () async {
                    final Map<String, dynamic> isVerified = await otpUser();
                    if (isVerified['status']) {
                      if (isVerified['userData']['userType'] == 'user') {
                        Navigator.pushReplacementNamed(context, 'SelectRole');
                      } else {
                        Navigator.pushReplacementNamed(context, 'Verify');
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid/Expired OTP'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 54,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(44, 42, 42, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Verify',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(255, 255, 255, 1),
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
