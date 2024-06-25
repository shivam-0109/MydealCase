import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/promotion_details_provider.dart';
import 'package:my_deal_case/View/AdManager/give_ad_widget.dart';
import 'package:my_deal_case/View/AdManager/my_ads_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key, required this.userDetails});
  final Map<String, dynamic> userDetails;
  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'My Ads',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GiveAdWidget(
                      userDetails: widget.userDetails,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_box_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ))
        ],
      ),
      body: FutureBuilder(
        future: getUserPromotions(widget.userDetails["userId"]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ListView.builder(
              itemCount: 5, // Number of ads
              itemBuilder: (context, index) {
                return Skeletonizer(
                  enabled: true,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Card(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Active',
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color.fromRGBO(
                                            245, 245, 245, 1),
                                      ),
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Image.asset(
                                              'assets/admanager/iphone.png'), // Replace with your CircleAvatar or image
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'I Phone 13 Pro',
                                      style: GoogleFonts.montserrat(
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cost Per Click',
                                          style: GoogleFonts.montserrat(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'INR 138.95',
                                          style: GoogleFonts.montserrat(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amount Spend',
                                      style: GoogleFonts.montserrat(
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'INR 500',
                                      style: GoogleFonts.montserrat(
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Link Clicks',
                                      style: GoogleFonts.montserrat(
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '231',
                                      style: GoogleFonts.montserrat(
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.green[400],
                                        ),
                                        child: Text(
                                          'Boost Ad',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Card(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Text(
                    "Please give ad of your product",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return MyAdsCardWidget(
                  promotionsDetails: snapshot.data![index],
                );
              },
            );
          }
        },
      ),
    );
  }
}
