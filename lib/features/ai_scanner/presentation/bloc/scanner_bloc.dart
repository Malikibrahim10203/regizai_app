import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/features/ai_scanner/domain/entities/scan_result_entity.dart';
import 'package:regizai/features/ai_scanner/domain/usecases/scan_food_usecase.dart';

// EVENTS
abstract class ScannerEvent extends Equatable {
  const ScannerEvent();
  @override
  List<Object?> get props => [];
}

class StartScanEvent extends ScannerEvent {
  final String foodName;
  const StartScanEvent(this.foodName);
  @override
  List<Object?> get props => [foodName];
}

class ResetScannerEvent extends ScannerEvent {}

// STATES
abstract class ScannerState extends Equatable {
  const ScannerState();
  @override
  List<Object?> get props => [];
}

class ScannerIdleState extends ScannerState {}

class ScanningState extends ScannerState {}

class ScanSuccessState extends ScannerState {
  final ScanResultEntity result;
  const ScanSuccessState(this.result);
  @override
  List<Object?> get props => [result];
}

class ScanErrorState extends ScannerState {
  final String message;
  const ScanErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

// BLOC
class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final ScanFoodUseCase scanFoodUseCase;

  ScannerBloc(this.scanFoodUseCase) : super(ScannerIdleState()) {
    on<StartScanEvent>((event, emit) async {
      emit(ScanningState());
      try {
        final res = await scanFoodUseCase(event.foodName);
        emit(ScanSuccessState(res));
      } catch (e) {
        emit(ScanErrorState(e.toString()));
      }
    });

    on<ResetScannerEvent>((event, emit) {
      emit(ScannerIdleState());
    });
  }
}
