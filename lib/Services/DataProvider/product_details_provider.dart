import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

///for setting and fetching product Id
class _ProductIdNotifier extends StateNotifier<String> {
  _ProductIdNotifier() : super("");

  void setProductId(String productId) {
    if (productId.isNotEmpty) {
      state = productId;
    } else {
      log("product id is empty");
    }
  }
}

final productIdProvider = StateNotifierProvider<_ProductIdNotifier, String>(
  (ref) => _ProductIdNotifier(),
);

///for getting product details
class _ProductDetailsNotifier extends StateNotifier<Map<String, dynamic>> {
  _ProductDetailsNotifier() : super({});

  void setProductDetails(Map<String, dynamic> details) {
    if (details != {}) {
      state = details;
    }
  }

  void setEmpty() {
    state = {};
  }
}

final productDetailsProvider =
    StateNotifierProvider<_ProductDetailsNotifier, Map<String, dynamic>>(
  (ref) => _ProductDetailsNotifier(),
);

class _AllProductsNotifier extends StateNotifier<List> {
  _AllProductsNotifier() : super([]);

  Future<void> getAllProduct() async {
    const apiUrl =
        'http://64.227.128.230/products?filter={ "offset": 0,"limit": 10,"skip": 0,"order": "createdAt desc","where":{},"include": [{"relation": "productType", "scope": { "offset": 0,"skip": 0,"order": "desc","fields": {},"include": []}}]}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      state = responseData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> getSelectedProduct(String categoryId) async {
    final apiUrl =
        'http://64.227.128.230/products?filter={ "offset": 0,"limit": 10,"skip": 0,"order": "createdAt desc","where":{"categoryId":"$categoryId" },"include": [{"relation": "productType", "scope": { "offset": 0,"skip": 0,"order": "desc","fields": {},"include": []}}]}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      state = responseData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final allProductProvider = StateNotifierProvider<_AllProductsNotifier, List>(
  (ref) => _AllProductsNotifier(),
);

class _ProductOfUserNotifier extends StateNotifier<List> {
  _ProductOfUserNotifier() : super([]);

  Future<void> getUserProduct(String userId) async {
    final apiUrl =
        'http://64.227.128.230/products?filter={   "offset": 0,"limit": 100,"skip": 0,"order": "createdAt desc","where": {"userId":"$userId"},"fields": {"productId": true,"name": true,"companyName": true,"description": true,"price": true,"stockItemCount": true,"soldItemCount": true,"availableItemCount": true,"specifications": true,"city": true,"fullName": true,"email": true,"mobileNumber": true,"discountPercentage": true,"images": true,"sellType": true,"createdAt": true,"userId": true,"categoryId": true,"subCategoryId": true,"productTypeId": true},"include": [{"relation": "user"}]}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseData = json.decode(response.body);

      state = responseData;
    } else {
      throw Exception('Failed to load userproductData');
    }
  }

  Future<bool> postUserProduct({
    required String productName,
    required String descripTion,
    required int productPrice,
    required Map specifiactions,
    required List city,
    required String userName,
    required String email,
    required String mobileNumber,
    required List<String> images,
    required String sellType,
    required String userId,
    required String categoryId,
    required String productTypeId,
  }) async {
    const apiUrl = 'http://64.227.128.230/products';

    try {
      final data = {
        "name": productName,
        "companyName": "string",
        "description": descripTion,
        "price": productPrice,
        "stockItemCount": 0,
        "soldItemCount": 0,
        "availableItemCount": 0,
        "specifications": specifiactions,
        "city": city,
        "fullName": userName,
        "email": email,
        "mobileNumber": mobileNumber,
        "discountPercentage": 0,
        "images": images,
        "sellType": sellType,
        "userId": userId,
        "categoryId": categoryId,
        "subCategoryId": "string",
        "productTypeId": productTypeId
      };

      final body = json.encode(data);

      final response = await http.post(
        Uri.parse(apiUrl),
        body: body,
        headers: {'content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print("productPost:${response.body}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Cant post product:${e.toString()}");
      return false;
    }
  }
}

final productOfUserProvider =
    StateNotifierProvider<_ProductOfUserNotifier, List>(
  (ref) => _ProductOfUserNotifier(),
);

/// get product types

class _ProductTypesNotifier extends StateNotifier<List> {
  _ProductTypesNotifier() : super([]);

  Future<void> getAllProductTypes() async {
    const apiUrl = 'http://64.227.128.230/product-types';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);

        state = responseData;
      }
    } catch (e) {
      print("Cant get productTypes:${e.toString()}");
    }
  }

  Future<String> postProductType({
    required String productTypeName,
    required List specifiacations,
    required String cateGoryId,
  }) async {
    const apiUrl = 'http://64.227.128.230/product-types';

    try {
      final data = {
        "name": productTypeName,
        "identifier": productTypeName.toLowerCase(),
        "specifications": specifiacations,
        "description": productTypeName.toLowerCase(),
        "status": "active",
        "categoryId": cateGoryId,
        "subCategoryId": "string"
      };

      final body = json.encode(data);

      final response = await http.post(
        Uri.parse(apiUrl),
        body: body,
        headers: {'content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print("productTypePost:${response.body}");
        return responseData["productTypeId"];
      } else {
        return "";
      }
    } catch (e) {
      print("Cant post productTypes:${e.toString()}");
      return "";
    }
  }
}

final productTypeProvider = StateNotifierProvider<_ProductTypesNotifier, List>(
  (ref) => _ProductTypesNotifier(),
);

class _ProductCategoriesNotifier extends StateNotifier<List> {
  _ProductCategoriesNotifier() : super([]);
  Future<void> getAllProductCategories() async {
    const apiUrl =
        'http://64.227.128.230/categories?filter={"where":{"categoryType":"product"}}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print("productCategories:${response.body}");
        state = responseData;
      }
    } catch (e) {
      print("Cant get productCategories:${e.toString()}");
    }
  }
}

final productCategoryProvider =
    StateNotifierProvider<_ProductCategoriesNotifier, List>(
  (ref) => _ProductCategoriesNotifier(),
);

class _GetProductByIdNotifier extends StateNotifier<Map<String, dynamic>> {
  _GetProductByIdNotifier() : super({});

  Future<void> getProductById(String productId) async {
    final apiUrl =
        'http://64.227.128.230/products/$productId?filter={ "offset": 0,"limit": 100,"skip": 0,"order": "createdAt desc","fields": {"productId": true,"name": true,"companyName": true,"description": true,"price": true,"stockItemCount": true,"soldItemCount": true,"availableItemCount": true,"specifications": true,"city": true,"fullName": true,"email": true,"mobileNumber": true,"discountPercentage": true,"images": true,"sellType": true,"createdAt": true,"userId": true,"categoryId": true,"subCategoryId": true,"productTypeId": true},"include": [{"relation": "productType"}]}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print("productIddata:${responseData}");
        state = responseData;
      } else {
        state = {};
      }
    } catch (e) {
      print("Cant get product from productId:${e.toString()}");
    }
  }
}

final getProductByIdProvider =
    StateNotifierProvider<_GetProductByIdNotifier, Map<String, dynamic>>(
  (ref) => _GetProductByIdNotifier(),
);
