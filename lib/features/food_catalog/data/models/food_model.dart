import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';

class FoodModel extends FoodEntity {
  const FoodModel({
    required super.id,
    required super.name,
    required super.category,
    required super.image,
    required super.calories,
    required super.protein,
    required super.fat,
    required super.carbs,
    required super.sugar,
    required super.vitamins,
    required super.portion,
    required super.description,
  });
}
