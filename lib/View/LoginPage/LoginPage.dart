// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/LoginService/LoginService.dart';

final TextEditingController numController = TextEditingController();
String Number = numController.text;
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State {
  TextEditingController countryCode = TextEditingController();

  @override
  void initState() {
    countryCode.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
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
                'Enter Your Mobile Number',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 1)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        '|',
                        style: TextStyle(
                            fontSize: 33,
                            color: Color.fromRGBO(218, 218, 218, 1)),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: numController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(159, 159, 159, 1),
                          ),
                        ),
                        validator: (value) {
                          //  print('In UserName Validator');
                          if (value == null || value.isEmpty) {
                            return null;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                textAlign: TextAlign.center,
                'By logging in you are agreeing to Heartcare+ Terms of Service and Privacy Policy',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(137, 137, 137, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 40, bottom: 5),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                highlightColor: Colors.grey,
                onTap: () async {
                  // bool loginValidated = formKey.currentState!.validate();
                  if (numController.text.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('OTP Sent'),
                      ),
                    );
                    await loginUser();
                    Navigator.pushReplacementNamed(context, 'OTP');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enter Mobile Number'),
                      ),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 54,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(44, 42, 42, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Proceed',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'New User?',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Create');
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(232, 80, 91, 1)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
