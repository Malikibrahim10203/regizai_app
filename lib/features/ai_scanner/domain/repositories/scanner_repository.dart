import 'package:regizai/features/ai_scanner/domain/entities/scan_result_entity.dart';

abstract class ScannerRepository {
  Future<ScanResultEntity> scanFood({String? foodName});
}
