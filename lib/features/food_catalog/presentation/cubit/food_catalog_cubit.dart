import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';
import 'package:regizai/features/food_catalog/domain/usecases/get_foods_usecase.dart';

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

  const FoodCatalogLoaded({
    required this.allFoods,
    required this.filteredFoods,
    required this.selectedCategory,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [allFoods, filteredFoods, selectedCategory, searchQuery];
}

class FoodCatalogError extends FoodCatalogState {
  final String message;
  const FoodCatalogError(this.message);
  @override
  List<Object?> get props => [message];
}

// CUBIT
class FoodCatalogCubit extends Cubit<FoodCatalogState> {
  final GetFoodsUseCase getFoodsUseCase;

  FoodCatalogCubit(this.getFoodsUseCase) : super(FoodCatalogInitial());

  void loadFoods() async {
    emit(FoodCatalogLoading());
    try {
      final list = await getFoodsUseCase(NoParams());
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
      _applyFilter(cur.allFoods, category, cur.searchQuery);
    }
  }

  void searchFood(String query) {
    if (state is FoodCatalogLoaded) {
      final cur = state as FoodCatalogLoaded;
      _applyFilter(cur.allFoods, cur.selectedCategory, query);
    }
  }

  void _applyFilter(List<FoodEntity> all, String category, String query) {
    final filtered = all.where((item) {
      final matchesCategory = category == "Semua" || item.category == category;
      final matchesSearch = item.name.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    emit(FoodCatalogLoaded(
      allFoods: all,
      filteredFoods: filtered,
      selectedCategory: category,
      searchQuery: query,
    ));
  }
}
