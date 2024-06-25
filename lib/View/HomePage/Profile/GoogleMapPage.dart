import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_deal_case/Services/DataProvider/user_details_provider.dart';
import 'package:my_deal_case/View/HomePage/Profile/Add_address.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

///use permission handler package

class GoogleMapPage extends ConsumerStatefulWidget {
  const GoogleMapPage({super.key});
  @override
  ConsumerState createState() => _GoogleMapState();
}

class _GoogleMapState extends ConsumerState {
  LatLng exaplePosition = const LatLng(21.9687252, 80.5233126);
  LatLng? currentPosition;
  Map? savedAddInfo;
  Map? userDetails;
  Map<String, dynamic> pos = {
    "lat": 0.0,
    "long": 0.0,
  };
  @override
  void initState() {
    super.initState();
    getAllSavedAddressInformation();
    checkAllPermission();
  }

  void checkAllPermission() async {
    await Permission.location.request();
    if (await Permission.location.isDenied) {
      Permission.location.request();
    } else if (await Permission.location.isPermanentlyDenied) {
      await openAppSettings();
      Navigator.pop(context);
    } else if (await Permission.location.isRestricted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Location is restricted on your phone"),
        ),
      );
    } else if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enable location"),
        ),
      );
    }
  }

  void getAllSavedAddressInformation() async {
    final prefs = await SharedPreferences.getInstance();
    userDetails = json.decode(prefs.getString("userData")!);
  }

  ///add permission handler

  //GOOGLE_MAP_KEY -> is the api key from enviorment

  void onConfrim() async {
    if (savedAddInfo != null && savedAddInfo!.isNotEmpty) {
      print(savedAddInfo);
      if (pos["lat"] != 0.0 || pos["long"] != 0.0) {
        print("uploading");
        final addressID = await ref
            .read(userAddressProvider.notifier)
            .saveUserAddress(
                userDetails!["fullName"],
                userDetails!["mobileNumber"],
                savedAddInfo!["pincode"],
                savedAddInfo!["address"],
                savedAddInfo!["city"],
                savedAddInfo!["addState"],
                savedAddInfo!["addressType"],
                pos["lat"],
                pos["long"],
                savedAddInfo!["addressType"] == Address.home.name,
                userDetails!["userId"]);
        print(addressID);
        ref.read(userAddressProvider.notifier).setAddEmpty();
        ref.read(userCurrentLocationProvider.notifier).setLocationEmpty();
        Navigator.pushReplacementNamed(context, "MyAddress");
      } else {
        ref.read(userCurrentLocationProvider.notifier).setLocationEmpty();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Tap on the screen"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("address details is required"),
        ),
      );
    }
  }

  void onBottomModalSheet(ctx) {
    showModalBottomSheet(context: context, builder: (context) => AddAddress());
  }

  @override
  Widget build(BuildContext context) {
    checkAllPermission();
    savedAddInfo = ref.watch(userAddressProvider);
    print(savedAddInfo);
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
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentPosition ?? exaplePosition,
              zoom: 14,
            ),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId("Home"),
                position: pos["lat"] == 0.0 || pos == null
                    ? exaplePosition
                    : LatLng(
                        pos["lat"],
                        pos["long"],
                      ),
              ),
            },
            onTap: (latLng) {
              setState(() {
                pos["lat"] = latLng.latitude;
                pos["long"] = latLng.longitude;
              });

              print(pos);
            },
          ),
          Positioned(
            top: 16,
            right: 60,
            child: Container(
              padding: EdgeInsets.all(5),
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: const Row(
                children: [
                  Text("Tap here to get your location"),
                  Icon(Icons.arrow_right)
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SELECT DELIVERY LOCATION",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      savedAddInfo == null || savedAddInfo!.isEmpty
                          ? Text(
                              "add location",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/location.svg"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${savedAddInfo!["address"]},${savedAddInfo!["city"]}",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${savedAddInfo!["addState"]}, ${savedAddInfo!["pincode"].toString()}",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: const Color.fromRGBO(232, 80, 91, 1),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            onBottomModalSheet(context);
                          },
                          child: Text(
                            savedAddInfo == null || savedAddInfo!.isEmpty
                                ? "add location"
                                : "change",
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(232, 80, 91, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(219, 0, 0, 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextButton(
                      onPressed: onConfrim,
                      child: Text(
                        "confirm",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
