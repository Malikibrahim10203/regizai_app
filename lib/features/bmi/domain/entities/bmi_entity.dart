import 'package:equatable/equatable.dart';

class BmiEntity extends Equatable {
  final double bmi;
  final String status;
  final String category;
  final int colorHex;
  final double idealMin;
  final double idealMax;
  final String advice;

  const BmiEntity({
    required this.bmi,
    required this.status,
    required this.category,
    required this.colorHex,
    required this.idealMin,
    required this.idealMax,
    required this.advice,
  });

  @override
  List<Object?> get props => [bmi, status, category, colorHex, idealMin, idealMax, advice];
}
