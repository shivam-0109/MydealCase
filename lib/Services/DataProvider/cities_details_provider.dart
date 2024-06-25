import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class _CitiesDetailsNOtifier extends StateNotifier<List> {
  _CitiesDetailsNOtifier() : super([]);

  Future<void> getCities() async {
    final url = 'http://64.227.128.230/cities';
    final urlParse = Uri.parse(url);
    try {
      final response = await http.get(urlParse);
      print(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        state = json.decode(response.body);
      }
    } catch (e) {
      print("Cant get cities:${e.toString()}");
    }
  }
}

final citiesDetailsProvider =
    StateNotifierProvider<_CitiesDetailsNOtifier, List>(
  (ref) => _CitiesDetailsNOtifier(),
);
