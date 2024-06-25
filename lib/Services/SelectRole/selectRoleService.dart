import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:my_deal_case/View/RoleScreen/RolePage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/LoginPage/otpScreen.dart';

Future<Map<String, dynamic>> updateUserType() async {
  //String? userData = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userData = prefs.getString("userData");
  print(userData);
  Map userObj = jsonDecode(userData!);

  print('start');
  var url = 'http://64.227.128.230/users/${userObj['userId']}';
  var data = {
    'userType': userTypeController.text,
  };
  var bodyy = json.encode(data);
  log(bodyy);
  var urlParse = Uri.parse(url);
  try {
    final response = await http.patch(
      urlParse,
      body: bodyy,
      headers: {'content-Type': 'application/json'},
    );
    userObj['userType'] = userTypeController.text;
    await prefs.setString('userData', jsonEncode(userObj));

    return {
      'status': true,
    };
  } catch (e) {
    print('Error: $e');

    return {
      'status': false,
    };
  }
}
