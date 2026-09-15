import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/features/journal/domain/entities/journal_log_entity.dart';
import 'package:regizai/features/journal/domain/usecases/journal_usecases.dart';

// EVENTS
abstract class JournalEvent extends Equatable {
  const JournalEvent();
  @override
  List<Object?> get props => [];
}

class LoadJournalEvent extends JournalEvent {
  final String userId;
  const LoadJournalEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class AddMealLogEvent extends JournalEvent {
  final String userId;
  final String namaMakanan;
  final String cal;
  const AddMealLogEvent({required this.userId, required this.namaMakanan, required this.cal});
  @override
  List<Object?> get props => [userId, namaMakanan, cal];
}

class DeleteMealLogEvent extends JournalEvent {
  final String idCapture;
  final String userId;
  const DeleteMealLogEvent({required this.idCapture, required this.userId});
  @override
  List<Object?> get props => [idCapture, userId];
}

// STATES
abstract class JournalState extends Equatable {
  const JournalState();
  @override
  List<Object?> get props => [];
}

class JournalInitialState extends JournalState {}

class JournalLoadingState extends JournalState {}

class JournalLoadedState extends JournalState {
  final List<JournalLogEntity> logs;
  final int todayCalories;
  const JournalLoadedState({required this.logs, required this.todayCalories});
  @override
  List<Object?> get props => [logs, todayCalories];
}

class JournalErrorState extends JournalState {
  final String message;
  const JournalErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

// BLOC
class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final GetJournalLogsUseCase getLogsUseCase;
  final AddJournalLogUseCase addLogUseCase;
  final DeleteJournalLogUseCase deleteLogUseCase;
  final GetTodayCaloriesUseCase getTodayCaloriesUseCase;

  JournalBloc({
    required this.getLogsUseCase,
    required this.addLogUseCase,
    required this.deleteLogUseCase,
    required this.getTodayCaloriesUseCase,
  }) : super(JournalInitialState()) {
    on<LoadJournalEvent>((event, emit) async {
      emit(JournalLoadingState());
      try {
        final logs = await getLogsUseCase(event.userId);
        final calories = await getTodayCaloriesUseCase(event.userId);
        emit(JournalLoadedState(logs: logs, todayCalories: calories));
      } catch (e) {
        emit(JournalErrorState(e.toString()));
      }
    });

    on<AddMealLogEvent>((event, emit) async {
      try {
        await addLogUseCase(
          AddJournalLogParams(
            userId: event.userId,
            namaMakanan: event.namaMakanan,
            cal: event.cal,
          ),
        );
        add(LoadJournalEvent(event.userId));
      } catch (e) {
        emit(JournalErrorState(e.toString()));
      }
    });

    on<DeleteMealLogEvent>((event, emit) async {
      try {
        await deleteLogUseCase(event.idCapture);
        add(LoadJournalEvent(event.userId));
      } catch (e) {
        emit(JournalErrorState(e.toString()));
      }
    });
  }
}
