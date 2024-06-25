import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_deal_case/Services/DataProvider/user_details_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadDocPage extends ConsumerStatefulWidget {
  const UploadDocPage({super.key});
  @override
  ConsumerState createState() => _Doc();
}

List data = [
  'Aadhaar Card-2022.pdf',
  'PAN Card-2022.pdf',
  'Registration Certificate-2022.pdf'
];

class _Doc extends ConsumerState {
  File? _aadhaarImage;
  File? _panCardImage;
  File? _registrationCertificateImage;
  late List userDocument;
  late Map<String, dynamic> userDetailsFromApi;

  List<bool> uploaded = [
    false,
    false,
    false,
  ];

  Map<String, dynamic>? userDetails;
  final imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString("userData");

    setState(() {
      userDetails = json.decode(user!);
    });

    await ref
        .read(userDocumentProvider.notifier)
        .getUserUploadedDocument(userDetails!["userId"]);
    await ref
        .read(userDetailsProvider.notifier)
        .getUserDetails(userDetails!["userId"]);
  }

  dynamic convertTobase64Image(File imageFile) {
    List<int> imageByte = imageFile.readAsBytesSync();
    String imageBase64 = base64Encode(imageByte);
    return imageBase64;
  }

  dynamic uploadImageInS3(
      String fileName, String fileType, String fileData) async {
    print("uploading");

    const url = "http://64.227.128.230/images/upload";
    final urlParse = Uri.parse(url);
    final data = {
      "fileName": fileName,
      "fileType": fileType,
      "fileData": fileData,
    };

    final body = json.encode(data);
    // print(body);

    try {
      final response = await http.post(
        urlParse,
        body: body,
        headers: {'content-Type': 'application/json'},
      );
      print(response.body);
      print("upload done");
      return response;
    } catch (e) {
      print("Error${e.toString()}");
    }
  }

  Future<void> uploadUserDocuments(
    String documentType,
    String fileName,
    String documentUrl,
    String fileType,
    String fileSize,
    String userId,
  ) async {
    print("Uploading on user");
    const url = "http://64.227.128.230/user-documents";
    final urlParse = Uri.parse(url);
    final data = {
      "documentType": documentType,
      "fileName": fileName,
      "documentUrl": documentUrl,
      "fileType": fileType,
      "fileSize": fileSize,
      "status": "unverified",
      "userId": userId,
      "additionalProp1": {}
    };
    final body = json.encode(data);

    try {
      final response = await http.post(
        urlParse,
        body: body,
        headers: {'content-Type': 'application/json'},
      );
      print("userDocument${response.body}");
      print("upload done");
    } catch (e) {
      print(e.toString());
    }
  }

  ///MARK: had to add file size compaision
  Future<void> getImage(int index) async {
    try {
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: true,
      );
      print(image!.path);

      switch (index) {
        case 0:
          {
            setState(() {
              _aadhaarImage = File(image.path);
            });
            String extention = p.extension(_aadhaarImage!.path);
            final fileSize = "${await _aadhaarImage!.length() / 1048576} mb";

            if ((await _aadhaarImage!.length() / 1048576) > 1.5) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("File size is bigger than 1.5 mb"),
                ),
              );
              break;
            }

            final aadhaarBase64Image = convertTobase64Image(_aadhaarImage!);

            final res = await uploadImageInS3(
              "Aadhaar_Card${const Uuid().v4()}",
              extention.substring(1),
              aadhaarBase64Image,
            );
            try {
              await uploadUserDocuments(
                extention,
                "Aadhaar_Card",
                json.decode(res.body)["fileUrl"],
                extention,
                fileSize,
                userDetails!["userId"],
              );

              setState(() {
                uploaded[0] = true;
              });
            } catch (e) {
              print(e.toString());
            }
          }
          break;
        case 1:
          {
            setState(() {
              _panCardImage = File(image.path);
            });
            String extention = p.extension(_panCardImage!.path);
            final fileSize = "${await _panCardImage!.length() / 1048576} mb";
            if ((await _panCardImage!.length() / 1048576) > 1.5) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("File size is bigger than 1.5 mb"),
                ),
              );
              break;
            }
            final panBase64Image = convertTobase64Image(_panCardImage!);
            final res = await uploadImageInS3(
              "Pan_Card${const Uuid().v4()}",
              extention.substring(1),
              panBase64Image,
            );
            try {
              await uploadUserDocuments(
                extention,
                "Pan_Card",
                json.decode(res.body)["fileUrl"],
                extention,
                fileSize,
                userDetails!["userId"],
              );

              setState(() {
                uploaded[1] = true;
              });
            } catch (e) {
              print(e.toString());
            }
          }
          break;
        case 2:
          {
            setState(() {
              _registrationCertificateImage = File(image.path);
            });
            String extention = p.extension(_registrationCertificateImage!.path);
            final fileSize =
                "${await _registrationCertificateImage!.length() / 1048576} mb";
            if ((await _registrationCertificateImage!.length() / 1048576) >
                1.5) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("File size is bigger than 1.5 mb"),
                ),
              );
              break;
            }
            final resgistrationBase64Image =
                convertTobase64Image(_registrationCertificateImage!);
            final res = await uploadImageInS3(
              "Registration_Certificate${const Uuid().v4()}",
              extention.substring(1),
              resgistrationBase64Image,
            );

            try {
              await uploadUserDocuments(
                extention,
                "Registration_Certificate",
                json.decode(res.body)["fileUrl"],
                extention,
                fileSize,
                userDetails!["userId"],
              );

              setState(() {
                uploaded[2] = true;
              });
            } catch (e) {
              print(e.toString());
            }
          }
        default:
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void submit() async {
    print("subbmitting");
    int count = 0;
    for (final item in uploaded) {
      if (item == true) {
        count++;
      }
    }
    print(count);
    if (count == 3) {
      if (userDetailsFromApi["status"].toString().toLowerCase() == "active") {
        await ref
            .read(userDetailsProvider.notifier)
            .patchUserDocumentStatus(userDetails!["userId"], "submitted");
        Navigator.pushNamed(context, 'UnderVerify');
      } else if (userDetailsFromApi["status"].toString().toLowerCase() ==
          "submitted") {
        Navigator.pushNamed(context, 'UnderVerify');
      } else if (userDetailsFromApi["status"].toString().toLowerCase() ==
          "verified") {
        Navigator.pushNamed(context, "UnderProceed");
      } else if (userDetailsFromApi["status"].toString().toLowerCase() ==
          "rejected") {
        Navigator.pushNamed(context, "Rejected");
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("All documents are required"),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    userDocument = ref.watch(userDocumentProvider);
    userDetailsFromApi = ref.watch(userDetailsProvider);
    // print(userDocument);

    for (final e in userDocument) {
      if (e["userId"] == userDetails!["userId"] &&
          e["fileName"] == "Aadhaar_Card") {
        setState(() {
          uploaded[0] = true;
        });
      }
      if (e["userId"] == userDetails!["userId"] &&
          e["fileName"] == "Pan_Card") {
        setState(() {
          uploaded[1] = true;
        });
      }
      if (e["userId"] == userDetails!["userId"] &&
          e["fileName"] == "Registration_Certificate") {
        setState(() {
          uploaded[2] = true;
        });
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
          'Upload KYC Documents',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/p1.svg',
                  height: 250,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 65, left: 65, top: 15),
                child: Text(
                  textAlign: TextAlign.center,
                  'Upload your documents for verification of your account with us.',
                  style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 70,
                  width: 353,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(211, 211, 211, 1),
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/images/doc.svg',
                    ),
                    title: Text(
                      data[index],
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    subtitle: Text(
                      '1.5 MB',
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(161, 161, 161, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        getImage(index);
                      },
                      child: uploaded[index] == true
                          ? const Icon(
                              Icons.done,
                              color: Colors.green,
                            )
                          : SvgPicture.asset(
                              'assets/images/add.svg',
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: InkWell(
          onTap: submit,
          child: Container(
            alignment: Alignment.center,
            height: 45,
            width: 290,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(44, 42, 42, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              textAlign: TextAlign.center,
              'Submit',
              style: GoogleFonts.montserrat(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
