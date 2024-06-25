import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdsManagerPage extends StatefulWidget {
  const AdsManagerPage({super.key});
  @override
  State createState() => _AdsManager();
}

class _AdsManager extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w600,
              fontSize: 24),
        ),
      ),
    );
  }
}
