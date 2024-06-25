import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _SearchedProductNotifier extends StateNotifier<List> {
  _SearchedProductNotifier() : super([]);
  Future<void> getSearchedProduct(String searchedText) async {
    final apiUrl =
        'http://64.227.128.230/products?filter={  "offset": 0,"limit": 10,"skip": 0,"order": "createdAt desc","where":{"name":{"regexp":"/$searchedText/ig"}},"include": [{"relation": "productType","scope": {"offset": 0,"skip": 0,"order": "desc","fields": {},"include": []}}]}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // print("searchedProduct:${response.body}");
      state = responseData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void setEmpty() {
    state = [];
  }
}

final searchedProductProvider =
    StateNotifierProvider<_SearchedProductNotifier, List>(
  (ref) => _SearchedProductNotifier(),
);
