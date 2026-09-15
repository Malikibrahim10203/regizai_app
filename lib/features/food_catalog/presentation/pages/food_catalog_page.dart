import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/food_catalog/presentation/cubit/food_catalog_cubit.dart';
import 'package:regizai/features/food_catalog/presentation/widgets/food_item_card.dart';

class FoodCatalogPage extends StatefulWidget {
  const FoodCatalogPage({super.key});

  @override
  State<FoodCatalogPage> createState() => _FoodCatalogPageState();
}

class _FoodCatalogPageState extends State<FoodCatalogPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedCategory = 'Semua';

  final List<Map<String, String>> _categories = [
    {'label': 'Semua', 'query': ''},
    {'label': 'Salad & Sayur', 'query': 'salad'},
    {'label': 'Buah Segar', 'query': 'fruit'},
    {'label': 'Ayam & Protein', 'query': 'chicken'},
    {'label': 'Ikan & Seafood', 'query': 'fish'},
    {'label': 'Nasi & Karbo', 'query': 'rice'},
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onCategorySelected(String label, String query) {
    setState(() => _selectedCategory = label);
    if (query.isEmpty) {
      _searchCtrl.clear();
      context.read<FoodCatalogCubit>().loadFoods();
    } else {
      _searchCtrl.text = query;
      context.read<FoodCatalogCubit>().searchFood(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSoft,
      appBar: AppBar(
        title: const Text(
          'Katalog Gizi FatSecret',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
      ),
      body: Column(
        children: [
          // Live FatSecret API Status Bar
          Container(
            margin: const EdgeInsets.fromLTRB(20, 4, 20, 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFECFDF5), Color(0xFFF0FDF4)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFA7F3D0)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x08065F46),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x6610B981),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'FatSecret Live Nutrition Database',
                    style: TextStyle(
                      color: Color(0xFF065F46),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF047857),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'CONNECTED',
                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.borderSubtle),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (q) => context.read<FoodCatalogCubit>().searchFood(q),
                decoration: InputDecoration(
                  hintText: 'Cari makanan (cth: chicken, rice, apple, apel)...',
                  hintStyle: const TextStyle(fontSize: 13, color: AppTheme.textSub),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.primaryGreen),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18, color: AppTheme.textSub),
                          onPressed: () {
                            _searchCtrl.clear();
                            context.read<FoodCatalogCubit>().loadFoods();
                            setState(() => _selectedCategory = 'Semua');
                          },
                        )
                      : null,
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Horizontal Category Filter Pills
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat['label'];

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => _onCategorySelected(cat['label']!, cat['query']!),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryGreen : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppTheme.primaryGreen : AppTheme.borderSubtle,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          cat['label']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected ? Colors.white : AppTheme.textMain,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // Status subtext
          BlocBuilder<FoodCatalogCubit, FoodCatalogState>(
            builder: (context, state) {
              if (state is FoodCatalogLoaded && state.isFromFatSecret) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_rounded, size: 14, color: Color(0xFF047857)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          state.searchQuery.isNotEmpty
                              ? 'Ditemukan ${state.filteredFoods.length} makanan resmi dari FatSecret API'
                              : 'Menampilkan rekomendasi live dari database FatSecret',
                          style: const TextStyle(fontSize: 11, color: Color(0xFF047857), fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Food List View
          Expanded(
            child: BlocBuilder<FoodCatalogCubit, FoodCatalogState>(
              builder: (context, state) {
                if (state is FoodCatalogLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(color: AppTheme.primaryGreen),
                        const SizedBox(height: 16),
                        Text(
                          'Mengambil data gizi langsung dari FatSecret...',
                          style: TextStyle(color: AppTheme.textSub, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                }
                if (state is FoodCatalogLoaded) {
                  if (state.filteredFoods.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'Makanan tidak ditemukan',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textMain),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Coba kata kunci lain (misal: rice, egg, salad)',
                            style: TextStyle(fontSize: 12, color: AppTheme.textSub),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
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
