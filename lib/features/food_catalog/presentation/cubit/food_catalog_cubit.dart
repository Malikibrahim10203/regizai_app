import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';
import 'package:regizai/features/food_catalog/domain/repositories/food_repository.dart';

// STATE
abstract class FoodCatalogState extends Equatable {
  const FoodCatalogState();
  @override
  List<Object?> get props => [];
}

class FoodCatalogInitial extends FoodCatalogState {}

class FoodCatalogLoading extends FoodCatalogState {}

class FoodCatalogLoaded extends FoodCatalogState {
  final List<FoodEntity> allFoods;
  final List<FoodEntity> filteredFoods;
  final String selectedCategory;
  final String searchQuery;
  final bool isFromFatSecret;

  const FoodCatalogLoaded({
    required this.allFoods,
    required this.filteredFoods,
    required this.selectedCategory,
    required this.searchQuery,
    this.isFromFatSecret = false,
  });

  @override
  List<Object?> get props => [allFoods, filteredFoods, selectedCategory, searchQuery, isFromFatSecret];
}

class FoodCatalogError extends FoodCatalogState {
  final String message;
  const FoodCatalogError(this.message);
  @override
  List<Object?> get props => [message];
}

// CUBIT
class FoodCatalogCubit extends Cubit<FoodCatalogState> {
  final FoodRepository repository;

  FoodCatalogCubit(this.repository) : super(FoodCatalogInitial());

  void loadFoods() async {
    emit(FoodCatalogLoading());
    try {
      final list = await repository.getFoods();
      emit(FoodCatalogLoaded(
        allFoods: list,
        filteredFoods: list,
        selectedCategory: "Semua",
        searchQuery: "",
      ));
    } catch (e) {
      emit(FoodCatalogError(e.toString()));
    }
  }

  void filterCategory(String category) {
    if (state is FoodCatalogLoaded) {
      final cur = state as FoodCatalogLoaded;
      final filtered = cur.allFoods.where((item) {
        return category == "Semua" || item.category == category;
      }).toList();

      emit(FoodCatalogLoaded(
        allFoods: cur.allFoods,
        filteredFoods: filtered,
        selectedCategory: category,
        searchQuery: cur.searchQuery,
      ));
    }
  }

  void searchFood(String query) async {
    if (query.trim().isEmpty) {
      loadFoods();
      return;
    }

    emit(FoodCatalogLoading());
    try {
      final results = await repository.searchFoods(query);
      emit(FoodCatalogLoaded(
        allFoods: results,
        filteredFoods: results,
        selectedCategory: "Semua",
        searchQuery: query,
        isFromFatSecret: true,
      ));
    } catch (_) {
      // Fallback
      loadFoods();
    }
  }
}
