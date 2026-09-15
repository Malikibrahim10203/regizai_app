import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:regizai/mock/mock_data.dart';
import 'package:regizai/model/catatan_harian.dart';
import 'package:regizai/model/response_api.dart';
import 'package:regizai/model/user.dart';

class OfflineService {
  static const String _keyUsers = "offline_users_list";
  static const String _keyCurrentUser = "offline_current_user";
  static const String _keyCatatan = "offline_catatan_list";

  static User get _defaultUser => User(
        id: "usr_01",
        name: "Malik Ibrahim",
        email: "user@regizai.com",
        emailVerifiedAt: "2026-01-01",
        password: "password123",
        gender: "male",
        birth: "2002-05-15",
        width: "65",
        height: "172",
        rememberToken: "token_abc123",
        createdAt: "2026-01-01",
        updatedAt: "2026-01-01",
      );

  // Initialize offline seed data if empty
  static Future<void> initSeedData() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Seed users if empty
    if (!prefs.containsKey(_keyUsers)) {
      final defaultUsers = [_defaultUser.toJson()];
      await prefs.setString(_keyUsers, jsonEncode(defaultUsers));
    }

    // 2. Seed default catatan if empty
    if (!prefs.containsKey(_keyCatatan)) {
      final now = DateTime.now();
      final dateStr = DateFormat('yyyy-MM-dd').format(now);
      final seedCatatan = [
        CatatanModel(
          idCapture: "cat_01",
          idUser: "usr_01",
          namaMakanan: "Bakso",
          cal: "325",
          tglCapture: "$dateStr 12:30",
        ).toJson(),
        CatatanModel(
          idCapture: "cat_02",
          idUser: "usr_01",
          namaMakanan: "Apel",
          cal: "95",
          tglCapture: "$dateStr 15:45",
        ).toJson(),
      ];
      await prefs.setString(_keyCatatan, jsonEncode(seedCatatan));
    }
  }

  // Auth: Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    await initSeedData();
    final prefs = await SharedPreferences.getInstance();
    final rawUsers = prefs.getString(_keyUsers);
    if (rawUsers != null) {
      final List usersJson = jsonDecode(rawUsers);
      for (var u in usersJson) {
        if (u['email'] == email.trim()) {
          if (u['password'] == password) {
            final user = User.fromJson(u);
            await prefs.setString(_keyCurrentUser, jsonEncode(user.toJson()));
            return {'success': true, 'message': 'Login berhasil', 'user': user};
          } else {
            return {'success': false, 'message': 'Password yang Anda masukkan salah'};
          }
        }
      }
    }

    // Quick demo login convenience: if demo email matches default
    if (email.trim().toLowerCase() == "user@regizai.com" && password == "password123") {
      final user = _defaultUser;
      await prefs.setString(_keyCurrentUser, jsonEncode(user.toJson()));
      return {'success': true, 'message': 'Login berhasil', 'user': user};
    }

    return {'success': false, 'message': 'Email tidak terdaftar. Silakan buat akun baru.'};
  }

  // Auth: Sign Up
  static Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String birth,
    required String width,
    required String height,
  }) async {
    await initSeedData();
    final prefs = await SharedPreferences.getInstance();
    final rawUsers = prefs.getString(_keyUsers);
    List users = rawUsers != null ? jsonDecode(rawUsers) : [];

    // Check duplicate
    for (var u in users) {
      if (u['email'] == email.trim()) {
        return {'success': false, 'message': 'Email sudah terdaftar. Silakan gunakan email lain.'};
      }
    }

    final newId = "usr_${DateTime.now().millisecondsSinceEpoch}";
    final nowStr = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final newUser = User(
      id: newId,
      name: name.trim().isEmpty ? "Pengguna Regizai" : name.trim(),
      email: email.trim(),
      emailVerifiedAt: nowStr,
      password: password,
      gender: gender,
      birth: birth,
      width: width.isEmpty ? "60" : width,
      height: height.isEmpty ? "170" : height,
      rememberToken: "token_$newId",
      createdAt: nowStr,
      updatedAt: nowStr,
    );

    users.add(newUser.toJson());
    await prefs.setString(_keyUsers, jsonEncode(users));
    await prefs.setString(_keyCurrentUser, jsonEncode(newUser.toJson()));

    return {'success': true, 'message': 'Pendaftaran akun berhasil!', 'user': newUser};
  }

  // Auth: Forgot Password (FR-03, UC-03)
  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    await initSeedData();
    final prefs = await SharedPreferences.getInstance();
    final rawUsers = prefs.getString(_keyUsers);
    if (rawUsers == null) {
      return {'success': false, 'message': 'Data pengguna tidak ditemukan'};
    }

    List users = jsonDecode(rawUsers);
    bool found = false;

    for (int i = 0; i < users.length; i++) {
      if (users[i]['email'] == email.trim()) {
        found = true;
        // Verify old password (or allow bypass if old password matches or user requested recovery)
        if (users[i]['password'] != oldPassword && oldPassword.isNotEmpty) {
          return {'success': false, 'message': 'Password lama tidak cocok.'};
        }

        users[i]['password'] = newPassword;
        users[i]['updated_at'] = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
        await prefs.setString(_keyUsers, jsonEncode(users));

        // Also update current active user if logged in
        final rawCurrent = prefs.getString(_keyCurrentUser);
        if (rawCurrent != null) {
          final cur = jsonDecode(rawCurrent);
          if (cur['email'] == email.trim()) {
            cur['password'] = newPassword;
            await prefs.setString(_keyCurrentUser, jsonEncode(cur));
          }
        }
        return {'success': true, 'message': 'Kata sandi berhasil diperbarui!'};
      }
    }

    if (!found) {
      return {'success': false, 'message': 'Akun dengan email tersebut tidak ditemukan.'};
    }

    return {'success': false, 'message': 'Gagal memperbarui kata sandi.'};
  }

  // Profile: Edit User
  static Future<Map<String, dynamic>> editUser({
    required String id,
    required String name,
    required String oldPassword,
    required String newPassword,
    required String width,
    required String height,
  }) async {
    await initSeedData();
    final prefs = await SharedPreferences.getInstance();
    final rawUsers = prefs.getString(_keyUsers);
    if (rawUsers == null) return {'success': false, 'message': 'User list not found'};

    List users = jsonDecode(rawUsers);
    for (int i = 0; i < users.length; i++) {
      if (users[i]['id'] == id) {
        if (newPassword.isNotEmpty) {
          if (oldPassword.isNotEmpty && users[i]['password'] != oldPassword) {
            return {'success': false, 'message': 'Password lama tidak sesuai'};
          }
          users[i]['password'] = newPassword;
        }

        if (name.isNotEmpty) users[i]['name'] = name;
        if (width.isNotEmpty) users[i]['width'] = width;
        if (height.isNotEmpty) users[i]['height'] = height;
        users[i]['updated_at'] = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

        await prefs.setString(_keyUsers, jsonEncode(users));
        final updated = User.fromJson(users[i]);
        await prefs.setString(_keyCurrentUser, jsonEncode(updated.toJson()));
        return {'success': true, 'message': 'Profil berhasil diperbarui', 'user': updated};
      }
    }

    return {'success': false, 'message': 'Pengguna tidak ditemukan'};
  }

  // Current User Getter
  static Future<User> getCurrentUser() async {
    await initSeedData();
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyCurrentUser);
    if (raw != null) {
      try {
        return User.fromJson(jsonDecode(raw));
      } catch (_) {}
    }
    return _defaultUser;
  }

  // Save current active user
  static Future<void> saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrentUser, jsonEncode(user.toJson()));
  }

  // Clear current active user (Logout)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCurrentUser);
  }

  // Catatan: Get List
  static Future<List<CatatanModel>> getCatatans(String userId) async {
    await initSeedData();
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyCatatan);
    if (raw == null) return [];

    try {
      final List decoded = jsonDecode(raw);
      final list = decoded.map((item) => CatatanModel.fromJson(item)).toList();
      return list.reversed.toList(); // Newest first
    } catch (_) {
      return [];
    }
  }

  // Catatan: Save item
  static Future<bool> saveCatatan({
    required String userId,
    required String namaMakanan,
    required String cal,
  }) async {
    await initSeedData();
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyCatatan);
    List items = raw != null ? jsonDecode(raw) : [];

    final nowStr = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final newItem = CatatanModel(
      idCapture: "cat_${DateTime.now().millisecondsSinceEpoch}",
      idUser: userId,
      namaMakanan: namaMakanan,
      cal: cal,
      tglCapture: nowStr,
    );

    items.add(newItem.toJson());
    await prefs.setString(_keyCatatan, jsonEncode(items));
    return true;
  }

  // Catatan: Delete item
  static Future<bool> deleteCatatan(String idCapture) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyCatatan);
    if (raw == null) return false;

    List items = jsonDecode(raw);
    items.removeWhere((item) => item['id_capture'] == idCapture);
    await prefs.setString(_keyCatatan, jsonEncode(items));
    return true;
  }

  // Catatan: Get today's total calories
  static Future<int> getTodayCalories(String userId) async {
    final list = await getCatatans(userId);
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int total = 0;
    for (var c in list) {
      if (c.tglCapture.contains(todayStr)) {
        total += int.tryParse(c.cal) ?? 0;
      }
    }
    return total;
  }

  // BMI Calculation Local Service
  static Map<String, dynamic> calculateBmi(double weightKg, double heightCm) {
    if (heightCm <= 0 || weightKg <= 0) {
      return {
        'bmi': 0.0,
        'status': 'Tidak Valid',
        'category': 'Data tidak valid',
        'color': 0xFF94A3B8,
        'idealMin': 0.0,
        'idealMax': 0.0,
        'advice': 'Pastikan tinggi dan berat badan lebih dari 0.',
      };
    }

    final heightM = heightCm / 100.0;
    final bmi = weightKg / (heightM * heightM);
    final idealMin = 18.5 * (heightM * heightM);
    final idealMax = 24.9 * (heightM * heightM);

    String status;
    String category;
    int colorValue;
    String advice;

    if (bmi < 18.5) {
      status = 'Kurus (Underweight)';
      category = 'Berat Badan Kurang';
      colorValue = 0xFF38BDF8;
      advice = 'Tingkatkan asupan kalori bernutrisi dan perbanyak makanan kaya protein untuk mencapai berat badan ideal.';
    } else if (bmi <= 24.9) {
      status = 'Normal (Ideal)';
      category = 'Berat Badan Sehat';
      colorValue = 0xFF10B981;
      advice = 'Pertahankan pola makan gizi seimbang dan aktivitas fisik teratur untuk menjaga kebugaran tubuh.';
    } else if (bmi <= 29.9) {
      status = 'Gemuk (Overweight)';
      category = 'Kelebihan Berat Badan';
      colorValue = 0xFFF59E0B;
      advice = 'Kurangi konsumsi gula dan lemak jenuh, serta perbanyak asupan sayur, buah, dan olahraga kardio.';
    } else {
      status = 'Obesitas';
      category = 'Risiko Tinggi';
      colorValue = 0xFFEF4444;
      advice = 'Konsultasikan dengan dokter/ahli gizi untuk program penurunan berat badan yang aman dan terukur.';
    }

    return {
      'bmi': double.parse(bmi.toStringAsFixed(1)),
      'status': status,
      'category': category,
      'color': colorValue,
      'idealMin': double.parse(idealMin.toStringAsFixed(1)),
      'idealMax': double.parse(idealMax.toStringAsFixed(1)),
      'advice': advice,
    };
  }

  // AI Food Recognition Simulation
  static ApiResponse simulateAiScan([String? preferredFoodName]) {
    // If specific food requested or random pick
    FoodItem item = MockData.foods.first;
    if (preferredFoodName != null && preferredFoodName.isNotEmpty) {
      final match = MockData.foods.firstWhere(
        (f) => f.name.toLowerCase() == preferredFoodName.toLowerCase(),
        orElse: () => MockData.foods.first,
      );
      item = match;
    }

    return ApiResponse(
      brand_name: item.name,
      protein: "${item.protein} g",
      fat: "${item.fat} g",
      carbs: "${item.carbs} g",
      cal: "${item.calories} kcal",
    );
  }
}
