import 'package:flutter/material.dart';
import 'package:regizai/event/event_db.dart';
import 'package:regizai/mock/mock_data.dart';
import 'package:regizai/mock/offline_service.dart';
import 'package:regizai/theme/app_theme.dart';

class Foods extends StatefulWidget {
  const Foods({super.key, required this.nameFood});

  final dynamic nameFood;

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  late FoodItem _item;
  String _userId = "usr_01";

  @override
  void initState() {
    super.initState();
    _loadFood();
    _loadUser();
  }

  void _loadUser() async {
    final user = await OfflineService.getCurrentUser();
    if (mounted) {
      setState(() => _userId = user.id ?? "usr_01");
    }
  }

  void _loadFood() {
    final query = widget.nameFood.toString().toLowerCase().trim();
    _item = MockData.foods.firstWhere(
      (f) => f.name.toLowerCase() == query,
      orElse: () => FoodItem(
        id: "0",
        name: widget.nameFood.toString(),
        category: "Makanan Sehat",
        image: "assets/img/${query}.png",
        calories: 250,
        protein: 10.0,
        fat: 8.0,
        carbs: 30.0,
        sugar: 4.0,
        vitamins: "Vitamin C, Mineral",
        portion: "1 Porsi Standar",
        description: "Makanan bergizi dengan kandungan seimbang untuk kebutuhan energi tubuh harian.",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_item.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Food Image Card
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppTheme.softShadow,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      _item.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.fastfood_rounded,
                        size: 80,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _item.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name & Portion
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _item.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.calorieBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${_item.calories} kcal",
                    style: const TextStyle(
                      color: AppColors.calorieColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Takaran Saji: ${_item.portion}",
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              _item.description,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // 4 Macro Grid
            const Text(
              "Kandungan Nutrisi Utama",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMacroPill("Protein", "${_item.protein} g", AppColors.proteinColor, AppColors.proteinBg),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMacroPill("Lemak", "${_item.fat} g", AppColors.fatColor, AppColors.fatBg),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildMacroPill("Karbohidrat", "${_item.carbs} g", AppColors.carbsColor, AppColors.carbsBg),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMacroPill("Gula Alami", "${_item.sugar} g", AppColors.accentOrange, AppColors.accentOrangeLight),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Vitamins Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.vitaminBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.medical_services_outlined, color: AppColors.vitaminColor, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Vitamin & Mineral",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _item.vitamins,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Action: Save to Catatan
            Container(
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: AppTheme.coloredShadow,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  EventDB.saveCatatan(_userId, _item.name, _item.calories.toString());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Catat ke Jurnal Konsumsi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroPill(String title, String value, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: AppTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
