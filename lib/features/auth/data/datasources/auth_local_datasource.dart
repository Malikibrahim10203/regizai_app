import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:regizai/core/error/failures.dart';
import 'package:regizai/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String birth,
    required String width,
    required String height,
  });
  Future<bool> forgotPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  });
  Future<UserModel?> getCurrentUser();
  Future<void> logout();
  Future<UserModel> editProfile({
    required String id,
    required String name,
    required String oldPassword,
    required String newPassword,
    required String width,
    required String height,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String keyUsers = "clean_arch_users";
  static const String keyCurrentUser = "clean_arch_current_user";

  AuthLocalDataSourceImpl(this.sharedPreferences);

  UserModel get _defaultUser => const UserModel(
        id: "usr_01",
        name: "Malik Ibrahim",
        email: "user@regizai.com",
        emailVerifiedAt: "2026-01-01",
        password: "password123",
        gender: "male",
        birth: "2002-05-15",
        width: "65",
        height: "172",
        createdAt: "2026-01-01",
        updatedAt: "2026-01-01",
      );

  Future<void> _ensureSeed() async {
    if (!sharedPreferences.containsKey(keyUsers)) {
      final list = [_defaultUser.toJson()];
      await sharedPreferences.setString(keyUsers, jsonEncode(list));
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    await _ensureSeed();
    final raw = sharedPreferences.getString(keyUsers);
    if (raw != null) {
      final List list = jsonDecode(raw);
      for (var u in list) {
        if (u['email'].toString().toLowerCase() == email.trim().toLowerCase()) {
          if (u['password'] == password) {
            final model = UserModel.fromJson(u);
            await sharedPreferences.setString(keyCurrentUser, jsonEncode(model.toJson()));
            return model;
          } else {
            throw const AuthFailure("Password yang Anda masukkan salah.");
          }
        }
      }
    }
    throw const AuthFailure("Email tidak terdaftar. Silakan buat akun baru.");
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String birth,
    required String width,
    required String height,
  }) async {
    await _ensureSeed();
    final raw = sharedPreferences.getString(keyUsers);
    List list = raw != null ? jsonDecode(raw) : [];

    for (var u in list) {
      if (u['email'].toString().toLowerCase() == email.trim().toLowerCase()) {
        throw const AuthFailure("Email sudah terdaftar. Silakan gunakan email lain.");
      }
    }

    final newId = "usr_${DateTime.now().millisecondsSinceEpoch}";
    final nowStr = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final newModel = UserModel(
      id: newId,
      name: name.trim().isEmpty ? "Pengguna Regizai" : name.trim(),
      email: email.trim(),
      emailVerifiedAt: nowStr,
      password: password,
      gender: gender,
      birth: birth,
      width: width.isEmpty ? "60" : width,
      height: height.isEmpty ? "170" : height,
      createdAt: nowStr,
      updatedAt: nowStr,
    );

    list.add(newModel.toJson());
    await sharedPreferences.setString(keyUsers, jsonEncode(list));
    await sharedPreferences.setString(keyCurrentUser, jsonEncode(newModel.toJson()));
    return newModel;
  }

  @override
  Future<bool> forgotPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    await _ensureSeed();
    final raw = sharedPreferences.getString(keyUsers);
    if (raw == null) throw const CacheFailure("Data pengguna tidak ditemukan");

    List list = jsonDecode(raw);
    bool found = false;

    for (int i = 0; i < list.length; i++) {
      if (list[i]['email'].toString().toLowerCase() == email.trim().toLowerCase()) {
        found = true;
        if (oldPassword.isNotEmpty && list[i]['password'] != oldPassword) {
          throw const AuthFailure("Password lama tidak sesuai.");
        }
        list[i]['password'] = newPassword;
        list[i]['updated_at'] = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
        await sharedPreferences.setString(keyUsers, jsonEncode(list));

        final rawCur = sharedPreferences.getString(keyCurrentUser);
        if (rawCur != null) {
          final cur = jsonDecode(rawCur);
          if (cur['email'] == email.trim()) {
            cur['password'] = newPassword;
            await sharedPreferences.setString(keyCurrentUser, jsonEncode(cur));
          }
        }
        return true;
      }
    }

    if (!found) {
      throw const AuthFailure("Akun dengan email tersebut tidak ditemukan.");
    }
    return false;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await _ensureSeed();
    final raw = sharedPreferences.getString(keyCurrentUser);
    if (raw != null) {
      try {
        return UserModel.fromJson(jsonDecode(raw));
      } catch (_) {}
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.remove(keyCurrentUser);
  }

  @override
  Future<UserModel> editProfile({
    required String id,
    required String name,
    required String oldPassword,
    required String newPassword,
    required String width,
    required String height,
  }) async {
    await _ensureSeed();
    final raw = sharedPreferences.getString(keyUsers);
    if (raw == null) throw const CacheFailure("User database not found");

    List list = jsonDecode(raw);
    for (int i = 0; i < list.length; i++) {
      if (list[i]['id'] == id) {
        if (newPassword.isNotEmpty) {
          if (oldPassword.isNotEmpty && list[i]['password'] != oldPassword) {
            throw const AuthFailure("Password lama tidak sesuai");
          }
          list[i]['password'] = newPassword;
        }
        if (name.isNotEmpty) list[i]['name'] = name;
        if (width.isNotEmpty) list[i]['width'] = width;
        if (height.isNotEmpty) list[i]['height'] = height;
        list[i]['updated_at'] = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

        await sharedPreferences.setString(keyUsers, jsonEncode(list));
        final updated = UserModel.fromJson(list[i]);
        await sharedPreferences.setString(keyCurrentUser, jsonEncode(updated.toJson()));
        return updated;
      }
    }
    throw const AuthFailure("Pengguna tidak ditemukan");
  }
}
