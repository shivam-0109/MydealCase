import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

List promotions = [];

Future<List> getPromotions() async {
  const apiUrl =
      'http://64.227.128.230/promotional-ads?filter={"offset": 0,"limit": 100,"skip": 0,"order": "string","where": {"additionalProp1": {}},"fields": {"promotionalAdId": true,"title": true,"description": true,"imageUrl": true,"validFrom": true,"validTill": true,"creditPoints": true,"impressions": true,"views": true,"conversions": true,"userId": true,"productId": true,"serviceId": true,"categoryId": true,"subCategoryId": true},"include": [{"relation": "product"}]}';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseData = json.decode(response.body);
      promotions = responseData;
      return responseData;
    } else {
      return [];
    }
  } catch (e) {
    print("Cant get productTypes:${e.toString()}");
    return [];
  }
}

List userPromotions = [];

Future<List> getUserPromotions(String userId) async {
  final apiUrl =
      'http://64.227.128.230/promotional-ads?filter={ "offset": 0,"limit": 100,"skip": 0,"order": "string","where": {"userId":"$userId"},"fields": {"promotionalAdId": true,"title": true,"description": true,"imageUrl": true,"validFrom": true,"validTill": true,"creditPoints": true,"impressions": true,"views": true,"conversions": true,"userId": true,"productId": true,"serviceId": true,"categoryId": true,"subCategoryId": true, "costPerClick":true,"amountSpend":true}}';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseData = json.decode(response.body);

      userPromotions = responseData;
      return responseData;
    } else {
      return [];
    }
  } catch (e) {
    print("Cant get productTypes:${e.toString()}");
    return [];
  }
}

class _GiveAddByUserNotifier extends StateNotifier<Map<String, dynamic>> {
  _GiveAddByUserNotifier() : super({});

  Future<bool> giveAd({
    required String title,
    required String description,
    required String imageUrl,
    required String validFrom,
    required String validTill,
    required String userId,
    required String productId,
    required String categoryId,
  }) async {
    const apiUrl = 'http://64.227.128.230/promotional-ads';

    try {
      final data = {
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "validFrom": validFrom,
        "validTill": validTill,
        "creditPoints": 0,
        "impressions": 0,
        "views": 0,
        "conversions": 0,
        "userId": userId,
        "productId": productId,
        "serviceId": "string",
        "categoryId": categoryId,
        "subCategoryId": "string",
        "costPerClick": 0,
        "amountSpend": 0
      };
      final body = json.encode(data);

      final response = await http.post(Uri.parse(apiUrl),
          body: body, headers: {'content-Type': 'application/json'});
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Cant get productTypes:${e.toString()}");
      return false;
    }
  }
}

final giveAdByUserProvider =
    StateNotifierProvider<_GiveAddByUserNotifier, Map<String, dynamic>>(
  (ref) => _GiveAddByUserNotifier(),
);
