import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:regizai/api/api.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/model/user.dart';
import 'package:get/get.dart';
import 'package:regizai/dashboard.dart';

class EventDB {

  static Future<User?> login(String email, String pass) async {
    User? user;

    try {
      var response = await http.post(Uri.parse(Api.login), body: {
        'email': email,
        'password' : pass,
      });

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          user = User.fromJson(responseBody['user']);
          EventPref.saveUser(user);
          Future.delayed(Duration(milliseconds: 1700), () {
            Get.off(
                Dashboard()
            );
          });
        } else {

        }
      } else {

      }
    } catch (e) {
      print(e);
    }
    return user;
  }
}