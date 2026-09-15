import 'package:regizai/features/ai_scanner/data/datasources/scanner_mock_datasource.dart';
import 'package:regizai/features/ai_scanner/domain/entities/scan_result_entity.dart';
import 'package:regizai/features/ai_scanner/domain/repositories/scanner_repository.dart';

class ScannerRepositoryImpl implements ScannerRepository {
  final ScannerMockDataSource dataSource;
  ScannerRepositoryImpl(this.dataSource);

  @override
  Future<ScanResultEntity> scanFood({String? foodName}) =>
      dataSource.scanFood(foodName: foodName);
}
