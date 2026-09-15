import 'package:regizai/features/ai_scanner/data/models/scan_result_model.dart';
import 'package:regizai/mock/mock_data.dart';

abstract class ScannerMockDataSource {
  Future<ScanResultModel> scanFood({String? foodName});
}

class ScannerMockDataSourceImpl implements ScannerMockDataSource {
  @override
  Future<ScanResultModel> scanFood({String? foodName}) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    FoodItem item = MockData.foods.first;
    if (foodName != null && foodName.isNotEmpty) {
      item = MockData.foods.firstWhere(
        (f) => f.name.toLowerCase() == foodName.toLowerCase(),
        orElse: () => MockData.foods.first,
      );
    }
    return ScanResultModel(
      foodName: item.name,
      calories: "${item.calories} kcal",
      protein: "${item.protein} g",
      fat: "${item.fat} g",
      carbs: "${item.carbs} g",
    );
  }
}
