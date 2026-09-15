import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';

abstract class FoodRepository {
  Future<List<FoodEntity>> getFoods();
  Future<List<FoodEntity>> searchFoods(String query);
}
