import 'package:regizai/features/food_catalog/data/models/food_model.dart';
import 'package:regizai/mock/mock_data.dart';

abstract class FoodMockDataSource {
  Future<List<FoodModel>> getFoods();
}

class FoodMockDataSourceImpl implements FoodMockDataSource {
  @override
  Future<List<FoodModel>> getFoods() async {
    return MockData.foods
        .map(
          (f) => FoodModel(
            id: f.id,
            name: f.name,
            category: f.category,
            image: f.image,
            calories: f.calories,
            protein: f.protein,
            fat: f.fat,
            carbs: f.carbs,
            sugar: f.sugar,
            vitamins: f.vitamins,
            portion: f.portion,
            description: f.description,
          ),
        )
        .toList();
  }
}
