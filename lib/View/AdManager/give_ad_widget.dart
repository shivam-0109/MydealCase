import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/promotion_details_provider.dart';
import 'package:my_deal_case/View/AdManager/MyAds.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class GiveAdWidget extends ConsumerStatefulWidget {
  const GiveAdWidget({super.key, required this.userDetails});
  final Map<String, dynamic> userDetails;
  @override
  ConsumerState<GiveAdWidget> createState() {
    return _GiveAdWidgetState();
  }
}

class _GiveAdWidgetState extends ConsumerState<GiveAdWidget> {
  TextEditingController adTitle = TextEditingController();
  TextEditingController adDescription = TextEditingController();
  bool isUploading = false;
  File? productImage;
  dynamic timerange;
  List<dynamic> userProducts = [];
  Map<String, dynamic> dropdownValue = {};
  @override
  void initState() {
    loadUserProducts();
    super.initState();
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

  void onAdded() async {
    if (productImage != null) {
      if (adTitle.text.isNotEmpty && adDescription.text.isNotEmpty) {
        if (timerange != null) {
          if (dropdownValue != {}) {
            final base64Image = convertTobase64Image(productImage!);
            String extention = p.extension(productImage!.path);
            final res = await uploadImageInS3(
              const Uuid().v4(),
              extention.substring(1),
              base64Image,
            );

            final done = await ref.read(giveAdByUserProvider.notifier).giveAd(
                title: adTitle.text,
                description: adDescription.text,
                imageUrl: json.decode(res.body)["fileUrl"],
                validFrom: timerange.start.toString(),
                validTill: timerange.end.toString(),
                userId: widget.userDetails["userId"],
                productId: dropdownValue["productId"],
                categoryId: dropdownValue["categoryId"]);

            if (done == true) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.red, content: Text("Ad uploaded")));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyAdsScreen(userDetails: widget.userDetails),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                      "Something went wrong while uploading,Please try again later")));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please add some product in productList page")));
            return;
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Timerange is required")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("All fields are  required")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Image is required")));
    }
  }

  void loadUserProducts() {
    ref
        .read(productOfUserProvider.notifier)
        .getUserProduct(widget.userDetails["userId"]);
  }

  @override
  Widget build(BuildContext context) {
    userProducts = ref.watch(productOfUserProvider);
    if (userProducts.isNotEmpty) {
      dropdownValue = userProducts[0];
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/images/back.svg',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 80, left: 60),
            child: Text(
              'Give Ad of Your Product',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ListView(children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: 300,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color.fromARGB(159, 158, 158, 158),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          final fileSize = (await image!.length() / 1048576);

                          if (fileSize < 1.5) {
                            setState(() {
                              productImage = File(image.path);
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Image size is greater than 1.5mb")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Something went wrong while getting image")));
                        }
                      },
                      child: productImage == null
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image),
                                  Text("Select your product Images"),
                                ],
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    productImage!,
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: adTitle,
                decoration: const InputDecoration(hintText: "Ad title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: adDescription,
                decoration: const InputDecoration(hintText: "Ad Description"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Choose Validity Range",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          final time = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime((DateTime.now().year + 2)),
                          );
                          setState(() {
                            timerange = time;
                          });
                        },
                        child: const Text(
                          "+Add",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(159, 158, 158, 158),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          timerange == null
                              ? "Start"
                              : timerange.start.toString().substring(0, 10),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(159, 158, 158, 158),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          timerange == null
                              ? "end"
                              : timerange.end.toString().substring(0, 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: userProducts.isEmpty ? false : true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Choose Your Product",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: DropdownButton<Map<String, dynamic>>(
                        isExpanded: true,
                        enableFeedback: true,
                        itemHeight: 100,
                        value: dropdownValue,
                        items: List.generate(
                          userProducts.length,
                          (index) {
                            return DropdownMenuItem(
                              value: userProducts[index],
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: double.infinity,
                                height: 100,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      child: Image.network(
                                          userProducts[index]["images"][0]),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      userProducts[index]["name"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          Positioned(
            bottom: 40,
            child: InkWell(
              onTap: onAdded,
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: isUploading == true
                    ? const CircularProgressIndicator(
                        color: Colors.red,
                      )
                    : const Text(
                        "Add",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
