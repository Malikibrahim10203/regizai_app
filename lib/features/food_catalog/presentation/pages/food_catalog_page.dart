import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/features/food_catalog/presentation/cubit/food_catalog_cubit.dart';
import 'package:regizai/features/food_catalog/presentation/widgets/food_item_card.dart';

class FoodCatalogPage extends StatelessWidget {
  const FoodCatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Makanan Sehat')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (q) => context.read<FoodCatalogCubit>().searchFood(q),
              decoration: InputDecoration(
                hintText: 'Cari makanan sehat...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<FoodCatalogCubit, FoodCatalogState>(
              builder: (context, state) {
                if (state is FoodCatalogLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FoodCatalogLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.filteredFoods.length,
                    itemBuilder: (context, index) {
                      final food = state.filteredFoods[index];
                      return FoodItemCard(
                        food: food,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.foodDetail, arguments: food);
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text('Katalog tidak tersedia'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
