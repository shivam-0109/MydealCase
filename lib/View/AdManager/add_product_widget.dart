import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';
import 'package:my_deal_case/View/AdManager/ProductList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class AddProductWidget extends ConsumerStatefulWidget {
  const AddProductWidget({super.key});
  @override
  ConsumerState<AddProductWidget> createState() {
    return _AddProductWidgetState();
  }
}

class _AddProductWidgetState extends ConsumerState<AddProductWidget> {
  List<File> productImages = [];
  late PageController pageController;
  int currentPage = 0;
  Map<String, dynamic>? userDetails;
  List productCategpries = [];
  List<String> productCategoriesName = ["Laptop"];
  String dropdownValue = "Laptop";

  Map<String, dynamic> specifiacations = {};
  int productSpecificationCount = 6;
  List specifiacationsInChunk = [];
  //product details controller

  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productType = TextEditingController();
  TextEditingController productPrice = TextEditingController();

  dynamic convertTobase64Image(File imageFile) {
    List<int> imageByte = imageFile.readAsBytesSync();
    String imageBase64 = base64Encode(imageByte);
    return imageBase64;
  }

  bool isUploading = false;

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

  void getProductImages() async {
    try {
      final images =
          await ImagePicker().pickMultiImage(requestFullMetadata: true);
      if (images.isNotEmpty) {
        for (final item in images) {
          final fileSize = (await item.length() / 1048576);
          print(fileSize);
          if (fileSize < 1.5) {
            productImages.add(File(item.path));
          }
        }
        if (images.length != productImages.length) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Looks like some images are bigger than 1.5 mb"),
            ),
          );
        }
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Somthing went wrong while getting images"),
        ),
      );
    }
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    loadAllData();
    super.initState();
  }

  void loadAllData() async {
    final prefs = await SharedPreferences.getInstance();

    userDetails = json.decode(prefs.getString("userData")!);

    await ref.read(productCategoryProvider.notifier).getAllProductCategories();
  }

  void addSpecification() {
    TextEditingController specifiationName = TextEditingController();
    TextEditingController specificationValue = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: const BoxConstraints.expand(),
      builder: (ctx) {
        return Container(
          height: 300,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: specifiationName,
                  decoration: const InputDecoration(hintText: "Specification"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: specificationValue,
                  decoration: const InputDecoration(hintText: "Value"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (specifiationName.text.isNotEmpty &&
                      specificationValue.text.isNotEmpty) {
                    if (specifiacations.entries.length == 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Cant add more than 6 Specification"),
                        ),
                      );
                      Navigator.of(ctx).pop();
                      return;
                    } else {
                      setState(() {
                        specifiacations.addAll(
                            {specifiationName.text: specificationValue.text});
                        productSpecificationCount--;
                        final chunk = {
                          "name": specifiationName.text,
                          "identifier": specifiationName.text,
                        };
                        specifiacationsInChunk.add(chunk);
                      });

                      print(specifiacations);
                      Navigator.of(ctx).pop();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }

  void onAdded() async {
    setState(() {
      isUploading = true;
    });
    String productCategoryId = "";

    for (final item in productCategpries) {
      if (item["name"] == dropdownValue) {
        productCategoryId = item["categoryId"];
      }
    }

    if (productImages.isNotEmpty) {
      if (productName.text.isNotEmpty &&
          productDescription.text.isNotEmpty &&
          productType.text.isNotEmpty &&
          productPrice.text.isNotEmpty) {
        if (specifiacations.length == 6) {
          //MARK: change this
          List<String> uploadedImages = [];
          int imageCount = 1;
          for (final item in productImages) {
            final base64Image = convertTobase64Image(item);
            String extention = p.extension(item.path);
            final s3ImageUrl = await uploadImageInS3(
              "${productName.text}_${const Uuid().v4()}_image$imageCount",
              extention.substring(1),
              base64Image,
            );

            if (s3ImageUrl.statusCode > 300) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text("Looks like some images are bigger than 1.5 mb"),
                ),
              );
              uploadedImages = [];
              setState(() {
                isUploading = false;
              });
              break;
            }
            final String imageUrl = json.decode(s3ImageUrl.body)["fileUrl"];

            uploadedImages.add(imageUrl);
            imageCount++;
          }

          if (uploadedImages.isNotEmpty) {
            print("uploading");
            try {
              final productTypeId = await ref
                  .read(productTypeProvider.notifier)
                  .postProductType(
                      productTypeName: productType.text,
                      specifiacations: specifiacationsInChunk,
                      cateGoryId: productCategoryId);
              print(specifiacations);
              final done = await ref
                  .read(productOfUserProvider.notifier)
                  .postUserProduct(
                      productName: productName.text,
                      descripTion: productDescription.text,
                      productPrice: int.parse(productPrice.text),
                      specifiactions: specifiacations,
                      city: [userDetails!["city"]],
                      userName: userDetails!["fullName"],
                      email: userDetails!["email"],
                      mobileNumber: userDetails!["mobileNumber"],
                      images: [...uploadedImages],
                      sellType: "string",
                      userId: userDetails!["userId"],
                      categoryId: productCategoryId,
                      productTypeId: productTypeId);

              ///MARK:this also
              if (done == true) {
                print("uploaded");
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "Product uploaded",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ProductList(),
                  ),
                );
              } else {
                setState(() {
                  isUploading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Something went wrong while uploading"),
                    ),
                  );
                });
              }
            } catch (e) {
              setState(() {
                isUploading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Something went wrong while uploading"),
                ),
              );
            }
          }
        } else {
          setState(() {
            isUploading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("4 specifiacations  are required"),
            ),
          );
        }
      } else {
        setState(() {
          isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("all fields are required"),
          ),
        );
      }
    } else {
      setState(() {
        isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Images are required"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    productCategpries = ref.watch(productCategoryProvider);
    if (productCategpries.isNotEmpty) {
      for (final item in productCategpries) {
        if (!productCategoriesName.contains(item["name"])) {
          productCategoriesName.add(item["name"]);
        }
      }
      setState(() {});
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
            padding: EdgeInsets.only(right: 100, left: 70),
            child: Text(
              'Review Your Details',
              style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 1),
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
          ListView(
            children: [
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
                        onTap: () {
                          getProductImages();
                        },
                        child: productImages.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image),
                                    Text("Select your product Images"),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                child: PageView.builder(
                                  controller: pageController,
                                  itemCount: productImages.length,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      currentPage = page;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return Image.file(
                                      productImages[index],
                                      height: 200,
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            productImages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: currentPage == index ? 10 : 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPage == index
                                    ? Colors.black
                                    : Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: productName,
                  decoration: const InputDecoration(hintText: "Product Name"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: productDescription,
                  decoration:
                      const InputDecoration(hintText: "Product Description"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: productType,
                  decoration: const InputDecoration(hintText: "Product Type"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: productPrice,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Product Price"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Choose Product Category",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      items: List.generate(
                        productCategoriesName.length,
                        (index) {
                          return DropdownMenuItem(
                            value: productCategoriesName[index],
                            child: Text(productCategoriesName[index]),
                          );
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                            "Product Specification ($productSpecificationCount)"),
                        Spacer(),
                        TextButton(
                          onPressed: addSpecification,
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
                    const Divider(),
                  ],
                ),
              ),
              Visibility(
                visible: specifiacations.isEmpty ? false : true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Specifiactions",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          ...List.generate(
                            specifiacations.length,
                            (index) {
                              return Container(
                                width: 120,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(159, 158, 158, 158),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(specifiacations.keys
                                    .toList()[index]
                                    .toString()),
                              );
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      Visibility(
                        visible: specifiacations.isEmpty ? false : true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            ...List.generate(
                              specifiacations.length,
                              (index) {
                                return Container(
                                  width: 120,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(159, 158, 158, 158),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(specifiacations.values
                                      .toList()[index]
                                      .toString()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Verified phone no.",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/phone_verified.png",
                          height: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        userDetails != null
                            ? Text(
                                "+91xxxxxx${userDetails!["mobileNumber"].toString().substring(6)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            : const Text(
                                "user phone number",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Confirm Location",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Location",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            userDetails != null
                                ? Text(
                                    "${userDetails!["city"]}",
                                    style: TextStyle(
                                      color: Colors.blue[400],
                                      fontSize: 12,
                                    ),
                                  )
                                : Text(
                                    "user city",
                                    style: TextStyle(
                                      color: Colors.blue[400],
                                      fontSize: 12,
                                    ),
                                  ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_right),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              )
            ],
          ),
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
