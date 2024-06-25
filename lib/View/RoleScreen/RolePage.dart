import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/SelectRole/selectRoleService.dart';

TextEditingController userTypeController = TextEditingController();

class RolePage extends StatefulWidget {
  const RolePage({super.key});
  @override
  State createState() => _HomeState();
}

class _HomeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 40,
            ),
            child: Center(
                child: Text(
              'Choose Your Role',
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(0, 0, 0, 1)),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        userTypeController.text = 'customer';
                        print('customer');
                      });
                    },
                    child: Container(
                      height: 220,
                      width: 190,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 206, 199, 0.35),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: userTypeController.text ==
                                                  'customer'
                                              ? 5
                                              : 2,
                                          color: const Color.fromRGBO(
                                              232, 80, 91, 1)),
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ],
                          ),
                          Center(
                              child:
                                  SvgPicture.asset('assets/images/Online.svg'))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'I am a Customer',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        userTypeController.text = 'manufacturer';
                        print('manufacturer');
                      });
                    },
                    child: Container(
                      height: 220,
                      width: 180,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 206, 199, 0.35),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: userTypeController.text ==
                                                  'manufacturer'
                                              ? 5
                                              : 2,
                                          color: const Color.fromRGBO(
                                              232, 80, 91, 1)),
                                      shape: BoxShape.circle),
                                ),
                              )
                            ],
                          ),
                          Center(
                              child: SvgPicture.asset(
                            'assets/images/MPR.svg',
                            fit: BoxFit.fill,
                          ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'I am a Manufacturer',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 14, bottom: 10, top: 5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      userTypeController.text = 'service-provider';
                      print('service-provider');
                    });
                  },
                  child: Container(
                    height: 220,
                    width: 190,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 206, 199, 0.35),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: userTypeController.text ==
                                                'service-provider'
                                            ? 5
                                            : 2,
                                        color: const Color.fromRGBO(
                                            232, 80, 91, 1)),
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ],
                        ),
                        Center(
                            child:
                                SvgPicture.asset('assets/images/Service.svg')),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 55,
                ),
                child: Text(
                  'I am a Service Provider',
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 1)),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 140, bottom: 5),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              highlightColor: Colors.white,
              onTap: () async {
                Map<String, dynamic> isConfirmed = await updateUserType();
                if (isConfirmed['status']) {
                  Navigator.pushNamed(context, 'UploadDoc');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something Went Wrong'),
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
                  'Confirm',
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
