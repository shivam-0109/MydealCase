import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SmsPage extends StatefulWidget {
  const SmsPage({super.key});
  @override
  State createState() => _SmsPage();
}

class _SmsPage extends State {
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
            'My Chats',
            style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ),
        body: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'ChatScreen');
          },
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/images/c1.png',
                    ),
                    title: Text(
                      'Andy Robertson',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    subtitle: Text(
                      'Oh yes, please send your offer...',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '5m ago',
                          style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(122, 122, 122, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 14,
                          width: 14,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(255, 114, 94, 0.35)),
                          child: Text(
                            '2',
                            style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(232, 80, 91, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 9),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(),
                  ),
                ],
              );
            },
          ),
        ),

    );
  }
}
