import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});
  @override
  State createState() => _WalletPage();
}

class _WalletPage extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(19),
            child: SvgPicture.asset(
              'assets/images/back.svg',
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'My Wallet',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          ListTile(
            title: Text(
              '₹0',
              style: GoogleFonts.montserrat(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            subtitle: Text(
              'Total wallet balance',
              style: GoogleFonts.montserrat(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 10),
            ),
            trailing: InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: 24,
                width: 84,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(232, 80, 91, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        'View History >',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 8),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 17, right: 10),
                        child: SvgPicture.asset(
                          'assets/images/cash.svg',
                        ),
                      ),
                      Text(
                        'Cash',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                        '₹0',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      SvgPicture.asset(
                        'assets/images/d2.svg',
                      ),
                      const SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Text(
                      'Earned from return of orders when paid using cash at the time of delivery.',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(86, 86, 86, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 17, right: 10),
                      child: SvgPicture.asset(
                        'assets/images/point.svg',
                      ),
                    ),
                    Text(
                      'Points',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    const Spacer(),
                    Text(
                      '₹0',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    SvgPicture.asset(
                      'assets/images/d2.svg',
                    ),
                    const SizedBox(
                      width: 30,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Text(
                    'Earned from promotions & offers with limited validity. Use upto 100%* on every purchase.',
                    style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(86, 86, 86, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 17, right: 10),
                      child: SvgPicture.asset(
                        'assets/images/cash.svg',
                      ),
                    ),
                    Text(
                      'Have a Gift Card?',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    'Add it to RENTZ Wallet to pay for your orders.',
                    style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(86, 86, 86, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 0, top: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: Text(
                          'T&C',
                          style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(232, 80, 91, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 120, right: 30),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Check Balance',
                            style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(232, 80, 91, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'add',
                          style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(232, 80, 91, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
