import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_deal_case/Services/DataProvider/user_details_provider.dart';

enum Address {
  home,
  work,
  other,
}

class AddAddress extends ConsumerStatefulWidget {
  const AddAddress({super.key});
  @override
  ConsumerState<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends ConsumerState<AddAddress> {
  String dropdownInitialValue = Address.home.name;
  List<String> addressType = [
    Address.home.name,
    Address.work.name,
    Address.other.name,
  ];

  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  final fromKey = GlobalKey<FormState>();

  void onSave() {
    if (fromKey.currentState!.validate()) {
      if (fromKey.currentState!.validate()) {
        ref.read(userAddressProvider.notifier).setCurrentAddress(
              int.parse(pincodeController.text),
              addressController.text,
              cityController.text,
              stateController.text,
              dropdownInitialValue,
            );
      }
      Navigator.of(context).pop();
    }
  }

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
        title: const Text("Add address"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select address type:",
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(86, 86, 86, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      DropdownButton<String>(
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        value: dropdownInitialValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: addressType
                            .map<DropdownMenuItem<String>>((String e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownInitialValue = value!;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: fromKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address line 1",
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(86, 86, 86, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(86, 86, 86, 1)),
                              ),
                              child: TextFormField(
                                controller: addressController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Address line 1",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(134, 0, 0, 0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter valid address";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pincode",
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(86, 86, 86, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(86, 86, 86, 1)),
                              ),
                              child: TextFormField(
                                controller: pincodeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Pincode",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(134, 0, 0, 0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length > 6) {
                                    return "Please enter valid pincode";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "City",
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(86, 86, 86, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(86, 86, 86, 1)),
                              ),
                              child: TextFormField(
                                controller: cityController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "City",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(134, 0, 0, 0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter valid city";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State",
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(86, 86, 86, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(86, 86, 86, 1)),
                              ),
                              child: TextFormField(
                                controller: stateController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "State",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(134, 0, 0, 0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter valid state";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 290,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(232, 80, 91, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: onSave,
                  child: Text(
                    "Save",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
