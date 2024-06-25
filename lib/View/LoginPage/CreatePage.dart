import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/cities_details_provider.dart';
import 'package:my_deal_case/Services/signupService/SignupService.dart';
import 'package:skeletonizer/skeletonizer.dart';

TextEditingController userNameController = TextEditingController();
TextEditingController userMobController = TextEditingController();
TextEditingController cityController = TextEditingController(text: "Delhi");

class CreatePage extends ConsumerStatefulWidget {
  const CreatePage({super.key});
  @override
  ConsumerState createState() => _CreateState();
}

class _CreateState extends ConsumerState {
  TextEditingController countryCode = TextEditingController();

  List citiesDetails = [];
  List<String> citiesName = [];
  @override
  void initState() {
    countryCode.text = '+91';
    loadCities();
    super.initState();
  }

  void loadCities() async {
    await ref.read(citiesDetailsProvider.notifier).getCities();
  }

  @override
  Widget build(BuildContext context) {
    citiesDetails = ref.watch(citiesDetailsProvider);
    print(citiesDetails);
    if (citiesDetails.isNotEmpty) {
      for (final item in citiesDetails) {
        if (!citiesName.contains(item["name"])) {
          citiesName.add(item["name"]);
        }
      }
    }
    print(citiesName);

    List<String> city = [...citiesName];

    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Center(
              child: Text(
                'Create Account',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                'Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: const Color.fromRGBO(187, 187, 187, 1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: userNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                'Mobile Number ',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: const Color.fromRGBO(187, 187, 187, 1)),
                  borderRadius: BorderRadius.circular(10),
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
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(0, 0, 0, 1)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '|',
                        style: TextStyle(
                            fontSize: 33,
                            color: Color.fromRGBO(218, 218, 218, 1)),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: userMobController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Mobile Number',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                'City',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: const Color.fromRGBO(187, 187, 187, 1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: cityController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          suffixIcon: Skeletonizer(
                            enabled: citiesName.isEmpty ? true : false,
                            child: DropdownButton<String>(
                              value: cityController.text,
                              borderRadius: BorderRadius.circular(10),
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  log('Selected: $newValue');
                                  cityController.text = newValue.toString();
                                });
                              },
                              items: <DropdownMenuItem<String>>[
                                ...List.generate(
                                  citiesName.length,
                                  (index) {
                                    return DropdownMenuItem<String>(
                                        value: city[index],
                                        child: Text(city[index]));
                                  },
                                ),
                              ],
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.check_box,
                    color: Color.fromRGBO(232, 80, 91, 1),
                  ),
                ),
                Text(
                  'I agree to the terms and conditions',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 70,
                bottom: 10,
              ),
              child: InkWell(
                onTap: () async {
                  if (userNameController.text.isNotEmpty &&
                      userMobController.text.isNotEmpty &&
                      cityController.text.isNotEmpty) {
                    await signUpUser();
                    await loginUser();

                    Navigator.pushNamed(context, 'OTP');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enter Missing Information'),
                      ),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(44, 42, 42, 1),
                      borderRadius: BorderRadius.circular(6)),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                textAlign: TextAlign.center,
                'Or Sign Up With',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 44,
                    width: 177,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/facebook.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('Facebook'),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 44,
                    width: 177,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/google.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('Google'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Login');
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(232, 80, 91, 1)),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
