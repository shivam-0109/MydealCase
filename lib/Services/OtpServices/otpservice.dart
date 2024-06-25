import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:my_deal_case/View/LoginPage/CreatePage.dart';
import 'dart:convert';
import 'package:my_deal_case/View/LoginPage/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/LoginPage/otpScreen.dart';

Future<Map<String, dynamic>> otpUser() async {
  print('start');
  var url = 'http://64.227.128.230/users/otp/verify';
  var data = {
    'mobileNumber': numController.text.isNotEmpty
        ? numController.text
        : userMobController.text,
    'code': otpController.text,
  };
  var bodyy = json.encode(data);
  log(bodyy);
  var urlParse = Uri.parse(url);
  try {
    final response = await http.post(
      urlParse,
      body: bodyy,
      headers: {'content-Type': 'application/json'},
    );
    final Map<String, dynamic> dataa = jsonDecode(response.body);
    print(dataa.toString());
    log('message');
    if (dataa['description'] == 'Otp is invalid') {
      return {
        'status': false,
      };
    } else {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('userData', jsonEncode(dataa['data']['userData']));

      print('end');
      return {
        'status': true,
        'userData': dataa['data']['userData'],
      };
    }
  } catch (e) {
    print('Error: $e');

    return {
      'status': false,
    };
  }
}
