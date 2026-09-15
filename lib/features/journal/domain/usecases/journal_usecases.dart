import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/journal/domain/entities/journal_log_entity.dart';
import 'package:regizai/features/journal/domain/repositories/journal_repository.dart';

class GetJournalLogsUseCase implements UseCase<List<JournalLogEntity>, String> {
  final JournalRepository repository;
  GetJournalLogsUseCase(this.repository);

  @override
  Future<List<JournalLogEntity>> call(String userId) => repository.getLogs(userId);
}

class AddJournalLogParams {
  final String userId;
  final String namaMakanan;
  final String cal;
  AddJournalLogParams({required this.userId, required this.namaMakanan, required this.cal});
}

class AddJournalLogUseCase implements UseCase<void, AddJournalLogParams> {
  final JournalRepository repository;
  AddJournalLogUseCase(this.repository);

  @override
  Future<void> call(AddJournalLogParams params) => repository.addLog(
        userId: params.userId,
        namaMakanan: params.namaMakanan,
        cal: params.cal,
      );
}

class DeleteJournalLogUseCase implements UseCase<void, String> {
  final JournalRepository repository;
  DeleteJournalLogUseCase(this.repository);

  @override
  Future<void> call(String idCapture) => repository.deleteLog(idCapture);
}

class GetTodayCaloriesUseCase implements UseCase<int, String> {
  final JournalRepository repository;
  GetTodayCaloriesUseCase(this.repository);

  @override
  Future<int> call(String userId) => repository.getTodayCalories(userId);
}
