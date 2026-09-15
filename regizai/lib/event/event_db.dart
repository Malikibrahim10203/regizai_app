import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/login.dart';
import 'package:regizai/mock/offline_service.dart';
import 'package:regizai/model/catatan_harian.dart';
import 'package:regizai/model/user.dart';
import 'package:regizai/pages/catatan.dart';
import 'package:regizai/pages/dashboard.dart';
import 'package:regizai/pages/profile.dart';

class EventDB {
  // Login with offline service
  static Future<User?> login(String email, String pass) async {
    User? user;
    try {
      final res = await OfflineService.login(email, pass);
      if (res['success'] == true) {
        user = res['user'] as User;
        EventPref.saveUser(user);
        Get.snackbar(
          "Sukses",
          "Selamat datang kembali, ${user.name}!",
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.offAll(() => const Dashboard());
        });
      } else {
        Get.snackbar(
          "Gagal Masuk",
          res['message'] ?? "Email atau password salah",
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint("Login Error: $e");
    }
    return user;
  }

  // Sign Up / Add User with offline service
  static Future<User?> addUser(
    String name,
    String email,
    String password,
    String gender,
    String birth,
    String width,
    String height,
  ) async {
    try {
      final res = await OfflineService.signup(
        name: name,
        email: email,
        password: password,
        gender: gender,
        birth: birth,
        width: width,
        height: height,
      );

      if (res['success'] == true) {
        final user = res['user'] as User;
        EventPref.saveUser(user);
        Get.snackbar(
          "Berhasil Mendaftar",
          "Akun Anda berhasil dibuat. Silakan login.",
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        Future.delayed(const Duration(milliseconds: 1200), () {
          Get.offAll(() => Login());
        });
        return user;
      } else {
        Get.snackbar(
          "Pendaftaran Gagal",
          res['message'] ?? "Terjadi kesalahan",
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      debugPrint("Add User Error: $e");
    }
    return null;
  }

  // Get list of catatan
  static Future<List<CatatanModel>> getCatatans(String id) async {
    try {
      return await OfflineService.getCatatans(id);
    } catch (e) {
      debugPrint("Get Catatan Error: $e");
      return [];
    }
  }

  // Edit User Profile
  static Future<User?> editUser(
    String id,
    String name,
    String oldPassword,
    String newPassword,
    String width,
    String height,
  ) async {
    try {
      final res = await OfflineService.editUser(
        id: id,
        name: name,
        oldPassword: oldPassword,
        newPassword: newPassword,
        width: width,
        height: height,
      );

      if (res['success'] == true) {
        final updatedUser = res['user'] as User;
        EventPref.saveUser(updatedUser);
        Get.snackbar(
          "Berhasil Disimpan",
          "Informasi profil Anda telah diperbarui.",
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.off(() => const Profile());
        });
        return updatedUser;
      } else {
        Get.snackbar(
          "Gagal Memperbarui",
          res['message'] ?? "Password lama tidak sesuai",
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      debugPrint("Edit User Error: $e");
    }
    return null;
  }

  // Get User Profile by ID
  static Future<List<User>> getUser(String id) async {
    try {
      final currentUser = await OfflineService.getCurrentUser();
      return [currentUser];
    } catch (e) {
      debugPrint("Get User Error: $e");
      return [];
    }
  }

  // Save Catatan
  static Future<void> saveCatatan(String id, String namaMakanan, String cal) async {
    try {
      await OfflineService.saveCatatan(
        userId: id,
        namaMakanan: namaMakanan,
        cal: cal,
      );
      Get.snackbar(
        "Tersimpan!",
        "$namaMakanan ($cal) telah dicatat ke jurnal gizi.",
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.off(() => Catatan(id: id));
      });
    } catch (e) {
      debugPrint("Save Catatan Error: $e");
    }
  }

  // Forgot Password (FR-03)
  static Future<bool> forgotPassword(String email, String oldPassword, String newPassword) async {
    try {
      final res = await OfflineService.forgotPassword(
        email: email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      if (res['success'] == true) {
        Get.snackbar(
          "Kata Sandi Diperbarui",
          "Silakan login dengan kata sandi baru Anda.",
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        Get.snackbar(
          "Gagal",
          res['message'] ?? "Gagal memperbarui password",
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      debugPrint("Forgot Password Error: $e");
      return false;
    }
  }
}