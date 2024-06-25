import 'dart:convert';
import 'package:http/http.dart' as http;

List postList = [];

Future<List> categoryApi() async {
  print('API Start');
  final response = await http.get(Uri.parse(
      'http://64.227.128.230/categories?filter={"where":{"categoryType":"product"}}'));
  final data = jsonDecode(response.body.toString());
  // print(data);
  if (response.statusCode == 200) {
    postList = data;

    return postList;
  } else {
    return postList;
  }
}
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

List<CategoryModel> userModelFromJson(String str) => List<CategoryModel>.from(
    json.decode(str).map((x) => CategoryModel.fromJson(x)));

String userModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  String categoryId;
  String name;
  String identifier;
  String description;
  String iconUrl;
  CategoryType categoryType;
  List<dynamic> city;
  bool status;
  DateTime createdAt;

  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.identifier,
    required this.description,
    required this.iconUrl,
    required this.categoryType,
    required this.city,
    required this.status,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["categoryId"],
        name: json["name"],
        identifier: json["identifier"],
        description: json["description"],
        iconUrl: json["iconUrl"],
        categoryType: categoryTypeValues.map[json["categoryType"]]!,
        city: List<dynamic>.from(json["city"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "identifier": identifier,
        "description": description,
        "iconUrl": iconUrl,
        "categoryType": categoryTypeValues.reverse[categoryType],
        "city": List<dynamic>.from(city.map((x) => x)),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
      };
}

enum CategoryType { PRODUCT, RENTAL, SERVICE }

final categoryTypeValues = EnumValues({
  "product": CategoryType.PRODUCT,
  "rental": CategoryType.RENTAL,
  "service": CategoryType.SERVICE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// Product Api
List<ProductModel> productList = [];
bool productLoader = false;
Future<List<ProductModel>> productApi() async {
  print('API Start');
  final response = await http.get(Uri.parse('http://64.227.128.230/products'));
  final data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map<String, dynamic> i in data) {
      productList.add(ProductModel.fromJson(i));
    }

    print('Product api call end');
    return productList;
  } else {
    return productList;
  }
}

//product details api
Map<String, dynamic> productdetails = {};
Future<Map<String, dynamic>> productDetailsApi(String productId) async {
  print("Getting product details");
  final response =
      await http.get(Uri.parse('http://64.227.128.230/products/$productId'));
  final data = json.decode(response.body);
  if (response.statusCode == 200) {
    productdetails = data;
    print("done");
    return productdetails;
  } else {
    return productdetails;
  }
}

// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String productId;
  String name;
  String companyName;
  String description;
  int price;
  int stockItemCount;
  int soldItemCount;
  int availableItemCount;
  Specifications specifications;
  List<String> city;
  String fullName;
  String email;
  String mobileNumber;
  int discountPercentage;
  List<String> images;
  String sellType;
  DateTime createdAt;
  String userId;
  String categoryId;
  String subCategoryId;
  String productTypeId;

  ProductModel({
    required this.productId,
    required this.name,
    required this.companyName,
    required this.description,
    required this.price,
    required this.stockItemCount,
    required this.soldItemCount,
    required this.availableItemCount,
    required this.specifications,
    required this.city,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.discountPercentage,
    required this.images,
    required this.sellType,
    required this.createdAt,
    required this.userId,
    required this.categoryId,
    required this.subCategoryId,
    required this.productTypeId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productId: json["productId"],
        name: json["name"],
        companyName: json["companyName"],
        description: json["description"],
        price: json["price"],
        stockItemCount: json["stockItemCount"],
        soldItemCount: json["soldItemCount"],
        availableItemCount: json["availableItemCount"],
        specifications: Specifications.fromJson(json["specifications"]),
        city: List<String>.from(json["city"].map((x) => x)),
        fullName: json["fullName"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        discountPercentage: json["discountPercentage"],
        images: List<String>.from(json["images"].map((x) => x)),
        sellType: json["sellType"],
        createdAt: DateTime.parse(json["createdAt"]),
        userId: json["userId"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        productTypeId: json["productTypeId"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "companyName": companyName,
        "description": description,
        "price": price,
        "stockItemCount": stockItemCount,
        "soldItemCount": soldItemCount,
        "availableItemCount": availableItemCount,
        "specifications": specifications.toJson(),
        "city": List<dynamic>.from(city.map((x) => x)),
        "fullName": fullName,
        "email": email,
        "mobileNumber": mobileNumber,
        "discountPercentage": discountPercentage,
        "images": List<dynamic>.from(images.map((x) => x)),
        "sellType": sellType,
        "createdAt": createdAt.toIso8601String(),
        "userId": userId,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "productTypeId": productTypeId,
      };
}

class Specifications {
  Specifications();

  factory Specifications.fromJson(Map<String, dynamic> json) =>
      Specifications();

  Map<String, dynamic> toJson() => {};
}
