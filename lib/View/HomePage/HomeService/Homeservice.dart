import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/services_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/user_details_provider.dart';

class HomeServiceScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeServiceScreen> createState() => _HomeServiceScreenState();
}

class _HomeServiceScreenState extends ConsumerState<HomeServiceScreen> {
  late Map<String, dynamic> selectedService;
  late List serviceCateGories;
  Map<String, dynamic> sellerDetails = {};
  @override
  void initState() {
    getSelectedServiceHere();
    super.initState();
  }

  void getSelectedServiceHere() async {
    selectedService = ref.read(selectedServiceProvider);
    serviceCateGories = ref.read(serviceCategoryProvider);
    await ref
        .read(userDetailsProvider.notifier)
        .getUserDetails(selectedService["userId"]);
  }

  @override
  Widget build(BuildContext context) {
    print(selectedService);
    print(serviceCateGories);
    String currentSeviceCategory = "category";
    if (serviceCateGories.isNotEmpty) {
      for (final item in serviceCateGories) {
        if (item["categoryId"] == selectedService["categoryId"]) {
          print("ongoing");
          currentSeviceCategory = item["name"];
          print("done");
        }
      }
      setState(() {});
    }
    sellerDetails = ref.watch(userDetailsProvider);
    print(sellerDetails);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Image
                selectedService["images"][0] == "string"
                    ? Image.asset(
                        'assets/images/repair.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height /
                            1.7, // Set image height to fill the screen
                        width: MediaQuery.of(context)
                            .size
                            .width, // Set image width to fill the screen
                      )
                    : Image.network(
                        selectedService["images"][0],
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height /
                            1.7, // Set image height to fill the screen
                        width: MediaQuery.of(context).size.width,
                      ),
                // Centered Card
                Positioned.fill(
                  top: MediaQuery.of(context).size.height /
                      3.5, // Adjust position as needed
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 250,
                      child: Card(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    currentSeviceCategory,
                                    style: GoogleFonts.montserrat(
                                      color:
                                          const Color.fromRGBO(232, 80, 91, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  const Icon(Icons.arrow_forward_ios_outlined,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                      size: 10),
                                  const SizedBox(width: 3),
                                  Text(
                                    selectedService["name"],
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromRGBO(
                                          121, 121, 121, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                selectedService["description"],
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedService["serviceCost"].toString(),
                                    style: GoogleFonts.montserrat(
                                      color:
                                          const Color.fromRGBO(232, 80, 91, 1),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    selectedService["discountPercentage"]
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Icon(Icons.call,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                      size: 20)
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Text(
                                    sellerDetails == {} || sellerDetails.isEmpty
                                        ? 'Seller Name'
                                        : sellerDetails["fullName"],
                                    style: GoogleFonts.montserrat(
                                      color:
                                          const Color.fromRGBO(232, 80, 91, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.orange, size: 15),
                                      const SizedBox(width: 3),
                                      Text(
                                        '4.5 ',

                                        ///MARK:have to change the review section
                                        style: GoogleFonts.montserrat(
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '( 50 reviews ) ',

                                    ///MARK:here also
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_pin,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                      size: 17),
                                  const SizedBox(width: 9),
                                  Expanded(
                                    child: Text(
                                      sellerDetails == {} ||
                                              sellerDetails.isEmpty
                                          ? "address city state"
                                          : "${sellerDetails["address"]}, ${sellerDetails["city"]}, ${sellerDetails["state"]}",
                                      style: GoogleFonts.montserrat(
                                        color:
                                            const Color.fromRGBO(92, 92, 92, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Photos/Videos',
                style: GoogleFonts.montserrat(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/repair.png',
                  height: 170,
                  width: 170,
                ),
                Image.asset(
                  'assets/images/repair.png',
                  height: 170,
                  width: 170,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/repair.png',
                  height: 170,
                  width: 170,
                ),
                Image.asset(
                  'assets/images/repair.png',
                  height: 170,
                  width: 170,
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'ChatScreen');
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 40, left: 20, right: 20, top: 20),
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(232, 80, 91, 1),
                          width: 3),
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white),
                  child: Text(
                    'Chat',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: const Color.fromRGBO(232, 80, 91, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'SelectDateScreen');
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 40, left: 20, right: 20, top: 20),
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color.fromRGBO(44, 42, 42, 1),
                  ),
                  child: Text(
                    'Book Now',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
