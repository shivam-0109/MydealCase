import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReferEarnPage extends StatefulWidget {
  const ReferEarnPage({super.key});
  @override
  State createState() => _ReferEarn();
}

class _ReferEarn extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 80, 91, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(232, 80, 91, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(19),
            child: SvgPicture.asset(
              'assets/images/back.svg',
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Refer & Earn',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ReferEarn
          SafeArea(
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/ReferEarn.svg',
                  height: 246,
                  width: 254,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 50,
                      right: 20,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Invite and Get ₹100 off on service',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SafeArea(
                minimum: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'How it works?',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    Stepper(
                      controlsBuilder:
                          (BuildContext context, ControlsDetails details) {
                        return Row(
                          children: <Widget>[
                            TextButton(
                              onPressed: details.onStepContinue,
                              child: Text(
                                '₹450 credited so far',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(232, 80, 91, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        );
                      },
                      //currentStep: 1,
                      steps: <Step>[
                        Step(
                          title: Text(
                            'Invite your friends & get rewarded',
                            style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          content: Container(
                            alignment: Alignment.centerLeft,
                            //  child: const Text('h'),
                          ),
                        ),
                        Step(
                          title: Text(
                            'They get ₹100 on their first service',
                            style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          content: Text('n'),
                        ),
                        Step(
                          title: Text(
                            'You get ₹100 once their service is completed',
                            style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          content: Text('m'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
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
                          'Invite Your Friends',
                          style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 10, left: 21),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Text(
                              'Terms and conditions',
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(232, 80, 91, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 30),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'FAQs',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(232, 80, 91, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
