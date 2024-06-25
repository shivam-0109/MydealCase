import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final List<Map<String, String>> onBoarding = [
    {
      'images': 'assets/images/1.svg',
      'title': 'Effortless Buying and Renting',
      'description':
          'Simplify your shopping experience by effortlessly buying or renting items with just a few taps, ensuring smoothness and convenience',
    },
    {
      'images': 'assets/images/2.svg',
      'title': 'Comprehensive Service Solutions',
      'description':
          'Enjoy easy access to a range of services for your purchased items, ensuring they remain in top-notch condition and receive necessary support whenever required.',
    },
    {
      'images': 'assets/images/3.svg',
      'title': 'Explore Diverse Offerings',
      'description':
          'Unlock endless potential with a range of offerings, from cutting-edge electronics to snug furniture and beyond, discovering the essentials to elevate your lifestyle.',
    },
    {
      'images': 'assets/images/4.svg',
      'title': 'Seamless Contributions, Meaningful Impact',
      'description':
          'Make a difference effortlessly by contributing to meaningful causes with just a few taps, ensuring your support goes where its needed most',
    },
    {
      'images': 'assets/images/5.svg',
      'title': 'Become a Partner',
      'description':
          'Make a difference effortlessly by contributing to meaningful causes with just a few taps, ensuring your support goes where its needed most',
    },
  ];

  late Color otherColor;

  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    otherColor = const Color.fromRGBO(0, 0, 0, 1);
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'Login');
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color.fromRGBO(232, 80, 91, 1),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: onBoarding.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: SvgPicture.asset(
                      onBoarding[index]['images']!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: Text(
                      onBoarding[index]['title']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: otherColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Text(
                      onBoarding[index]['description']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: otherColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (currentPage == (onBoarding.length - 1))
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'Login');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            alignment: Alignment.center,
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromRGBO(44, 42, 42, 1),
                            ),
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onBoarding.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 10,
                              width: (index == currentPage) ? 20 : 8,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: (index == currentPage)
                                    ? const Color.fromRGBO(39, 45, 47, 1)
                                    : const Color.fromRGBO(217, 217, 217, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: currentPage != (onBoarding.length - 1),
        child: InkWell(
          highlightColor: Colors.black,
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            if (currentPage < (onBoarding.length - 1)) {
              pageController.animateToPage(
                currentPage + 1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(44, 42, 42, 1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
