import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Inventory',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5, // Number of ads
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              color: const Color.fromRGBO(255, 255, 255, 1),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(245, 245, 245, 1),
                          ),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset('assets/admanager/iphone.png'), // Replace with your CircleAvatar or image
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dell Inspiran i9 11th gen',
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0,0,0,1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Delivered on Tue, 3 Nov',
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(130, 130, 130, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.arrow_forward_ios,size: 10,)
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromRGBO(245, 245, 245, 1),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(0,0,0,1),
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '70 left',
                            style: GoogleFonts.montserrat(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

            ),
          );
        },
      ),
    );
  }
}
