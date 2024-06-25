import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class _SimilerProductNotifier extends StateNotifier<List> {
  _SimilerProductNotifier() : super([]);

  Future<void> getSimilerProduct({required String productTypeId}) async {
    final apiUrl =
        'http://64.227.128.230/products?filter={ "offset": 0,"limit": 100,"skip": 0,"order": "string","where": {"productTypeId":"$productTypeId"},"fields": {"productId": true,"name": true,"companyName": true,"description": true,"price": true,"stockItemCount": true,"soldItemCount": true,"availableItemCount": true,"specifications": true,"city": true,"fullName": true,"email": true,"mobileNumber": true,"discountPercentage": true,"images": true,"sellType": true,"createdAt": true,"userId": true,"categoryId": true,"subCategoryId": true,"productTypeId": true},"include": [{"relation":"productType"}]}';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        // print("seimilerProduct:${response.body}");
        state = responseData;
      }
    } catch (e) {
      print("cant get similer product:${e.toString()}");
    }
  }
}

final similerProductProvider =
    StateNotifierProvider<_SimilerProductNotifier, List>(
  (ref) => _SimilerProductNotifier(),
);
