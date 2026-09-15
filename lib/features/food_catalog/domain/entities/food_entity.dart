import 'package:equatable/equatable.dart';

class FoodEntity extends Equatable {
  final String id;
  final String name;
  final String category;
  final String image;
  final int calories;
  final double protein;
  final double fat;
  final double carbs;
  final double sugar;
  final String vitamins;
  final String portion;
  final String description;

  const FoodEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.sugar,
    required this.vitamins,
    required this.portion,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        image,
        calories,
        protein,
        fat,
        carbs,
        sugar,
        vitamins,
        portion,
        description,
      ];
}
