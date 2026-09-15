import 'package:regizai/features/journal/data/datasources/journal_local_datasource.dart';
import 'package:regizai/features/journal/domain/entities/journal_log_entity.dart';
import 'package:regizai/features/journal/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalLocalDataSource localDataSource;
  JournalRepositoryImpl(this.localDataSource);

  @override
  Future<List<JournalLogEntity>> getLogs(String userId) => localDataSource.getLogs(userId);

  @override
  Future<void> addLog({required String userId, required String namaMakanan, required String cal}) =>
      localDataSource.addLog(userId: userId, namaMakanan: namaMakanan, cal: cal);

  @override
  Future<void> deleteLog(String idCapture) => localDataSource.deleteLog(idCapture);

  @override
  Future<int> getTodayCalories(String userId) => localDataSource.getTodayCalories(userId);
}
