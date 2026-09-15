import 'package:regizai/features/journal/domain/entities/journal_log_entity.dart';

abstract class JournalRepository {
  Future<List<JournalLogEntity>> getLogs(String userId);
  Future<void> addLog({
    required String userId,
    required String namaMakanan,
    required String cal,
  });
  Future<void> deleteLog(String idCapture);
  Future<int> getTodayCalories(String userId);
}
