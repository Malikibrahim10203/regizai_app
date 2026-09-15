import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/features/bmi/domain/entities/bmi_entity.dart';
import 'package:regizai/features/bmi/domain/usecases/calculate_bmi_usecase.dart';

abstract class BmiState extends Equatable {
  const BmiState();
  @override
  List<Object?> get props => [];
}

class BmiInitialState extends BmiState {}

class BmiCalculatedState extends BmiState {
  final BmiEntity bmiData;
  const BmiCalculatedState(this.bmiData);
  @override
  List<Object?> get props => [bmiData];
}

class BmiCubit extends Cubit<BmiState> {
  final CalculateBmiUseCase calculateBmiUseCase;

  BmiCubit(this.calculateBmiUseCase) : super(BmiInitialState());

  void calculate(double weightKg, double heightCm) async {
    final result = await calculateBmiUseCase(
      BmiParams(weightKg: weightKg, heightCm: heightCm),
    );
    emit(BmiCalculatedState(result));
  }
}
