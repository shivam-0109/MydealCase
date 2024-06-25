import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

List allServices = [];

Future<List> getAllServices() async {
  final url =
      'http://64.227.128.230/services?filter={"offset": 0,"limit": 100,"skip": 0,"order": "createdAt desc","where": {"additionalProp1": {}},"fields": {"serviceId": true,"name": true,"city": true,"description": true,"serviceCost": true,"extraCost": true,"totalCost": true,"discountPercentage": true,"status": true,"images": true,"createdAt": true,"userId": true,"categoryId": true,"subCategoryId": true,"serviceTypeId": true},"include": [{"relation": "user"}]}';
  final urlParse = Uri.parse(url);

  try {
    final response = await http.get(urlParse);
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      allServices = json.decode(response.body);
      print(allServices);
      return json.decode(response.body);
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}

class _AllServiceTypes extends StateNotifier<List> {
  _AllServiceTypes() : super([]);

  Future<void> getAllServiceType() async {
    final url = 'http://64.227.128.230/service-types';
    final urlParse = Uri.parse(url);
    try {
      final response = await http.get(urlParse);
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        state = json.decode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

final allServiceTypesProvider = StateNotifierProvider<_AllServiceTypes, List>(
  (ref) => _AllServiceTypes(),
);

class _SelectedServiceNotifier extends StateNotifier<Map<String, dynamic>> {
  _SelectedServiceNotifier() : super({});

  void getSelectedService(Map<String, dynamic> details) {
    state = details;
  }
}

final selectedServiceProvider =
    StateNotifierProvider<_SelectedServiceNotifier, Map<String, dynamic>>(
  (ref) => _SelectedServiceNotifier(),
);

class _ServiceCategoryNotifier extends StateNotifier<List> {
  _ServiceCategoryNotifier() : super([]);

  Future<void> getAllServiceCategory() async {
    final url =
        'http://64.227.128.230/categories?filter= { "offset": 0,"limit": 100,"skip": 0,"order": "string","where": {"categoryType":"service"},"fields": {"categoryId": true,"name": true,"identifier": true,"description": true,"iconUrl": true,"imageUrl": true,"categoryType": true,"city": true,"status": true,"createdAt": true}}';
    final urlParse = Uri.parse(url);

    try {
      final response = await http.get(urlParse);
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        state = json.decode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

final serviceCategoryProvider =
    StateNotifierProvider<_ServiceCategoryNotifier, List>(
  (ref) => _ServiceCategoryNotifier(),
);

class _SelectedDateTime extends StateNotifier<Map<String, String>> {
  _SelectedDateTime() : super({});
  void getDate(String date) {
    state = {
      "date": date,
    };
  }

  void getTime(String time) {
    state = {
      "date": state["date"]!,
      "time": time,
    };
  }
}

final selectedDateAndTimeProvider =
    StateNotifierProvider<_SelectedDateTime, Map<String, String>>(
  (ref) => _SelectedDateTime(),
);
