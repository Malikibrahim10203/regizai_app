import 'package:equatable/equatable.dart';

class ScanResultEntity extends Equatable {
  final String foodName;
  final String calories;
  final String protein;
  final String fat;
  final String carbs;

  const ScanResultEntity({
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  @override
  List<Object?> get props => [foodName, calories, protein, fat, carbs];
}
