import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

Future<List> getTopBrands({required String brandType}) async {
  final url =
      'http://64.227.128.230/brands?filter={ "offset": 0,"limit": 100,"skip": 0,"order": "string","where": {"brandType":"$brandType"},"fields": {"brandId": true,"name": true,"description": true,"imageUrl": true,"images": true,"brandType": true,"status": true,"categoryList": true,"createdAt": true}}';
  final urlParse = Uri.parse(url);
  try {
    final response = await http.get(
      urlParse,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}

class _SelecTedBrandNotifier extends StateNotifier<Map<String, dynamic>> {
  _SelecTedBrandNotifier() : super({});

  void getSelectedBrand(Map<String, dynamic> selectedBrand) {
    state = selectedBrand;
  }
}

final selectedBrandProvider =
    StateNotifierProvider<_SelecTedBrandNotifier, Map<String, dynamic>>(
  (ref) => _SelecTedBrandNotifier(),
);

List brandedCategories = [];

Future<List> getBrandCateGoryDetails(List categoryList) async {
  List categories = [];

  for (final item in categoryList) {
    final url = 'http://64.227.128.230/categories/$item';
    final urlParse = Uri.parse(url);
    try {
      final response = await http.get(
        urlParse,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        categories.add(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
  if (categories.isNotEmpty) {
    brandedCategories = categories;
    return categories;
  } else {
    return [];
  }
}

Future<List> getBradedProduct(String searchedText) async {
  final url =
      'http://64.227.128.230/products?filter={  "offset": 0,"limit": 10,"skip": 0,"order": "createdAt desc","where":{"name":{"regexp":"/$searchedText/ig"}},"include": [{"relation": "productType","scope": {"offset": 0,"skip": 0,"order": "desc","fields": {},"include": []}}]}';
  final urlParse = Uri.parse(url);
  try {
    final response = await http.get(
      urlParse,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}

Future<List> getBradedProductWithCategory(
    String searchedText, String categoryId) async {
  final url =
      'http://64.227.128.230/products?filter={  "offset": 0,"limit": 10,"skip": 0,"order": "createdAt desc","where":{"name":{"regexp":"/$searchedText/ig"},"categoryId":"$categoryId"},"include": [{"relation": "productType","scope": {"offset": 0,"skip": 0,"order": "desc","fields": {},"include": []}}]}';
  final urlParse = Uri.parse(url);
  try {
    final response = await http.get(
      urlParse,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}
