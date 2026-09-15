import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/ai_scanner/domain/entities/scan_result_entity.dart';
import 'package:regizai/features/ai_scanner/domain/repositories/scanner_repository.dart';

class ScanFoodUseCase implements UseCase<ScanResultEntity, String?> {
  final ScannerRepository repository;
  ScanFoodUseCase(this.repository);

  @override
  Future<ScanResultEntity> call(String? foodName) => repository.scanFood(foodName: foodName);
}
