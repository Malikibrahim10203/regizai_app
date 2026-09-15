import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';
import 'package:regizai/features/food_catalog/domain/repositories/food_repository.dart';

class GetFoodsUseCase implements UseCase<List<FoodEntity>, NoParams> {
  final FoodRepository repository;
  GetFoodsUseCase(this.repository);

  @override
  Future<List<FoodEntity>> call(NoParams params) => repository.getFoods();
}
