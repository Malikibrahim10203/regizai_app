import 'package:regizai/features/ai_scanner/data/models/scan_result_model.dart';

abstract class ScannerMockDataSource {
  Future<ScanResultModel> scanFood({String? foodName});
}

class ScannerMockDataSourceImpl implements ScannerMockDataSource {
  @override
  Future<ScanResultModel> scanFood({String? foodName}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const ScanResultModel(
      foodName: 'Nasi Goreng Sehat Spesial',
      calories: '420 kcal',
      protein: '18.5 g',
      fat: '12.0 g',
      carbs: '55.0 g',
    );
  }
}
