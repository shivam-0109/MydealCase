import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/user_details_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddressPage extends ConsumerStatefulWidget {
  const MyAddressPage({super.key});
  @override
  ConsumerState createState() => _MyAddress();
}

class _MyAddress extends ConsumerState {
  List? userAllAddress;
  List userAddress = [];
  Map? userDetails;
  List<String> address = [
    'Home',
    'Work',
    'Other',
  ];
  List<String> myIcon = [
    'assets/images/homeI.svg',
    'assets/images/work.svg',
    'assets/images/locI.svg',
  ];

  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  void loadAddress() async {
    final pref = await SharedPreferences.getInstance();
    userDetails = json.decode(pref.getString("userData")!);
    await ref
        .read(allUserProvider.notifier)
        .getAlluserAddress(userDetails!["userId"]);
  }

  @override
  Widget build(BuildContext context) {
    print(userDetails);
    print(userAllAddress);
    userAllAddress = ref.watch(allUserProvider);
    if (userDetails != null && userDetails!.isNotEmpty) {
      if (userAllAddress!.isNotEmpty && userAllAddress != null) {
        for (final item in userAllAddress!) {
          print(item["userId"]);
          if (item["userId"] == userDetails!["userId"]) {
            if (!userAddress.contains(item["userAddressId"])) {
              userAddress.add(item);
            }
          }
        }
        setState(() {});
      }
    }

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
          'Checkout',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
      ),
      body: SizedBox(
        // height: double.infinity,
        width: double.infinity,
        child: userAddress.isEmpty
            ? const Center(
                child: Text("No address found"),
              )
            : ListView.builder(
                itemCount: userAddress.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 5),
                              child: SvgPicture.asset(
                                userAddress[index]["addressType"] == "home"
                                    ? myIcon[0]
                                    : userAddress[index]["addressType"] ==
                                            "work"
                                        ? myIcon[1]
                                        : userAddress[index]["addressType"] ==
                                                "other"
                                            ? myIcon[2]
                                            : myIcon[0],
                              ),
                            ),
                            Text(
                              userAddress[index]["addressType"],
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 55, right: 15),
                          child: Text(
                            "${userAddress[index]["address"]} ${userAddress[index]["city"]} ${userAddress[index]["state"]} ${userAddress[index]["pincode"]}",
                            style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(86, 86, 86, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 55),
                          child: Text(
                            'Phone number - ${userAddress[index]["mobileNumber"]}',
                            style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(86, 86, 86, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 55, right: 0, top: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'EDIT',
                                    style: GoogleFonts.montserrat(
                                        color: const Color.fromRGBO(
                                            232, 80, 91, 1),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 35, right: 30),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'DELETE',
                                    style: GoogleFonts.montserrat(
                                        color: const Color.fromRGBO(
                                            232, 80, 91, 1),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'SHARE',
                                  style: GoogleFonts.montserrat(
                                      color:
                                          const Color.fromRGBO(232, 80, 91, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 85),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, 'GoogleMap');
          },
          child: Container(
              alignment: Alignment.center,
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(232, 80, 91, 1),
                  )),
              child: Text(
                '+ Add another addess',
                style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(232, 80, 91, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              )),
        ),
      ),
    );
  }
}
