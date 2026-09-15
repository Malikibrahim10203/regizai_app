import 'package:regizai/features/food_catalog/data/datasources/food_mock_datasource.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';
import 'package:regizai/features/food_catalog/domain/repositories/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodMockDataSource dataSource;
  FoodRepositoryImpl(this.dataSource);

  @override
  Future<List<FoodEntity>> getFoods() => dataSource.getFoods();
}
