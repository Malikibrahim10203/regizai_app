import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:regizai/api/api.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/login.dart';
import 'package:regizai/model/catatan_harian.dart';
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

  static Future<User?> addUser(String name, String email, String password, String gender, String birth, String width, String height) async {

    try {
      var response = await http.post(Uri.parse(Api.signup), body: {
        'email': email,
        'password': password,
        'gender': gender,
        'name': name,
        'birth': birth,
        'width': width,
        'height': height,
      });

      if (response.statusCode == 200) {
        Future.delayed(Duration(milliseconds: 1700), () {
          Get.off(
            Login(),
          );
        });
      } else {

      }

    } catch (e) {
      print(e);
    }
  }

  static Future<List<CatatanModel>> getCatatans(String id) async {
    List<CatatanModel> listUser = [];

    try {
      var response = await http.post(Uri.parse(Api.getCatatan), body: {
        "id": id
      });

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var users = responseBody['catatan'];
          users.forEach((user) {
            listUser.add(CatatanModel.fromJson(user));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listUser;
  }
}