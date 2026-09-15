import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:regizai/features/journal/data/models/journal_log_model.dart';

abstract class JournalLocalDataSource {
  Future<List<JournalLogModel>> getLogs(String userId);
  Future<void> addLog({required String userId, required String namaMakanan, required String cal});
  Future<void> deleteLog(String idCapture);
  Future<int> getTodayCalories(String userId);
}

class JournalLocalDataSourceImpl implements JournalLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String keyJournal = "clean_arch_journal_list";

  JournalLocalDataSourceImpl(this.sharedPreferences);

  Future<void> _ensureSeed() async {
    if (!sharedPreferences.containsKey(keyJournal)) {
      final now = DateTime.now();
      final dateStr = DateFormat('yyyy-MM-dd').format(now);
      final seed = [
        JournalLogModel(
          idCapture: "cat_01",
          idUser: "usr_01",
          namaMakanan: "Bakso",
          cal: "325",
          tglCapture: "$dateStr 12:30",
        ).toJson(),
        JournalLogModel(
          idCapture: "cat_02",
          idUser: "usr_01",
          namaMakanan: "Apel",
          cal: "95",
          tglCapture: "$dateStr 15:45",
        ).toJson(),
      ];
      await sharedPreferences.setString(keyJournal, jsonEncode(seed));
    }
  }

  @override
  Future<List<JournalLogModel>> getLogs(String userId) async {
    await _ensureSeed();
    final raw = sharedPreferences.getString(keyJournal);
    if (raw == null) return [];
    try {
      final List list = jsonDecode(raw);
      final models = list.map((item) => JournalLogModel.fromJson(item)).toList();
      return models.reversed.toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> addLog({required String userId, required String namaMakanan, required String cal}) async {
    await _ensureSeed();
    final raw = sharedPreferences.getString(keyJournal);
    List list = raw != null ? jsonDecode(raw) : [];

    final nowStr = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final newModel = JournalLogModel(
      idCapture: "cat_${DateTime.now().millisecondsSinceEpoch}",
      idUser: userId,
      namaMakanan: namaMakanan,
      cal: cal,
      tglCapture: nowStr,
    );

    list.add(newModel.toJson());
    await sharedPreferences.setString(keyJournal, jsonEncode(list));
  }

  @override
  Future<void> deleteLog(String idCapture) async {
    final raw = sharedPreferences.getString(keyJournal);
    if (raw == null) return;
    List list = jsonDecode(raw);
    list.removeWhere((item) => item['id_capture'] == idCapture);
    await sharedPreferences.setString(keyJournal, jsonEncode(list));
  }

  @override
  Future<int> getTodayCalories(String userId) async {
    final logs = await getLogs(userId);
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int total = 0;
    for (var l in logs) {
      if (l.tglCapture.contains(todayStr)) {
        total += int.tryParse(l.cal) ?? 0;
      }
    }
    return total;
  }
}
