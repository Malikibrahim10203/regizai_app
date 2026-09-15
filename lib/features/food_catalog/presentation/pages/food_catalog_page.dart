import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/food_catalog/presentation/cubit/food_catalog_cubit.dart';
import 'package:regizai/features/food_catalog/presentation/widgets/food_item_card.dart';

class FoodCatalogPage extends StatelessWidget {
  const FoodCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Makanan Sehat'),
      ),
      body: Column(
        children: [
          // FatSecret API Status Badge
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFA5D6A7)),
            ),
            child: Row(
              children: [
                const Icon(Icons.cloud_done_rounded, color: Color(0xFF2E7D32), size: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'FatSecret REST API Active (Live Database)',
                    style: TextStyle(
                      color: Color(0xFF1B5E20),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'CONNECTED',
                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: TextField(
              onChanged: (q) => context.read<FoodCatalogCubit>().searchFood(q),
              decoration: InputDecoration(
                hintText: 'Cari makanan di FatSecret (cth: chicken, rice, apple)...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.primaryGreen),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),
          BlocBuilder<FoodCatalogCubit, FoodCatalogState>(
            builder: (context, state) {
              if (state is FoodCatalogLoaded && state.isFromFatSecret) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                  child: Row(
                    children: [
                      const Icon(Icons.verified, size: 14, color: Color(0xFF2E7D32)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          state.searchQuery.isNotEmpty
                              ? 'Hasil pencarian langsung dari server FatSecret (${state.filteredFoods.length} makanan)'
                              : 'Rekomendasi pangan segar live dari FatSecret Platform API',
                          style: const TextStyle(fontSize: 11, color: Color(0xFF2E7D32), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: BlocBuilder<FoodCatalogCubit, FoodCatalogState>(
              builder: (context, state) {
                if (state is FoodCatalogLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppTheme.primaryGreen),
                        SizedBox(height: 12),
                        Text('Memuat data gizi dari FatSecret API...', style: TextStyle(color: AppTheme.textSub)),
                      ],
                    ),
                  );
                }
                if (state is FoodCatalogLoaded) {
                  if (state.filteredFoods.isEmpty) {
                    return const Center(child: Text('Makanan tidak ditemukan. Coba kata kunci lain.'));
                  }
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
