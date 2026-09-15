import 'package:regizai/features/food_catalog/data/datasources/fatsecret_remote_datasource.dart';
import 'package:regizai/features/food_catalog/data/datasources/food_mock_datasource.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';
import 'package:regizai/features/food_catalog/domain/repositories/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodMockDataSource mockDataSource;
  final FatSecretRemoteDataSource fatSecretDataSource;

  FoodRepositoryImpl({
    required this.mockDataSource,
    required this.fatSecretDataSource,
  });

  @override
  Future<List<FoodEntity>> getFoods() async {
    // Default catalog starts with curated healthy foods
    return await mockDataSource.getFoods();
  }

  @override
  Future<List<FoodEntity>> searchFoods(String query) async {
    if (query.trim().isEmpty) {
      return await mockDataSource.getFoods();
    }

    // Try online FatSecret API first if credentials are configured
    if (fatSecretDataSource.hasValidCredentials) {
      try {
        final remoteFoods = await fatSecretDataSource.searchFoods(query);
        if (remoteFoods.isNotEmpty) {
          return remoteFoods;
        }
      } catch (_) {}
    }

    // Fallback to local search
    final all = await mockDataSource.getFoods();
    return all.where((item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
