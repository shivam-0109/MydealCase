import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});
  @override
  State createState() => _FavPage();
}

class _FavPage extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'My Favourites',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 323,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(245, 245, 245, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                        decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      hintText: 'Search...',
                      enabledBorder: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.search_outlined,
                        color: Color.fromRGBO(164, 164, 164, 1),
                      ),
                      hintStyle: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(164, 164, 164, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  ),
                ),
                const Spacer(),
                SvgPicture.asset('assets/images/filter.svg'),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Text(
              '12 Favourites',
              style: GoogleFonts.montserrat(
                  color: const Color.fromRGBO(232, 80, 91, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 220,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 8,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              )
                            ],
                          ),
                          child: SafeArea(
                            minimum: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/refri.png'),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Samsung Refrigerator',
                                        style: GoogleFonts.montserrat(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.favorite,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      '₹ 70,000',
                                      style: GoogleFonts.montserrat(
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹ 85000',
                                      style: GoogleFonts.montserrat(
                                          color: const Color.fromRGBO(
                                              170, 169, 169, 1),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 220,
                          width: 170,
                          margin: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 8,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              )
                            ],
                          ),
                          child: SafeArea(
                            minimum: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/refri.png'),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Samsung Refrigerator',
                                        style: GoogleFonts.montserrat(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.favorite,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      '₹ 70,000',
                                      style: GoogleFonts.montserrat(
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹ 85000',
                                      style: GoogleFonts.montserrat(
                                          color: const Color.fromRGBO(
                                              170, 169, 169, 1),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),

    );
  }
}
