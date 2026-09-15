import 'package:regizai/features/ai_scanner/domain/entities/scan_result_entity.dart';

class ScanResultModel extends ScanResultEntity {
  const ScanResultModel({
    required super.foodName,
    required super.calories,
    required super.protein,
    required super.fat,
    required super.carbs,
  });
}
