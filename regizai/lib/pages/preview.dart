import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:regizai/event/event_db.dart';
import 'package:regizai/model/response_api.dart';
import 'package:regizai/theme/app_theme.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({
    Key? key,
    required this.picture,
    required this.apiResponse,
    required this.id,
  }) : super(key: key);

  final XFile picture;
  final ApiResponse apiResponse;
  final dynamic id;

  @override
  Widget build(BuildContext context) {
    final foodName = apiResponse.brand_name.isEmpty ? "Makanan Sehat" : apiResponse.brand_name;
    final imageAssetPath = "assets/img/${foodName.toLowerCase()}.png";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Hasil Analisis Gizi AI"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Food Image Hero Card
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
                      imageAssetPath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.fastfood_rounded, size: 80, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.check_circle_rounded, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "AI Terverifikasi",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Title & Food Name
            Text(
              foodName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Rincian kandungan gizi per takaran saji teridentifikasi",
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // Grid of Nutrition (Calorie, Protein, Fat, Carbs)
            Row(
              children: [
                Expanded(
                  child: _buildNutrientCard(
                    title: "Total Kalori",
                    value: apiResponse.cal.replaceAll("kcal", "").trim(),
                    unit: "kcal",
                    icon: Icons.local_fire_department_rounded,
                    color: AppColors.calorieColor,
                    bgColor: AppColors.calorieBg,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildNutrientCard(
                    title: "Protein",
                    value: apiResponse.protein.replaceAll("g", "").trim(),
                    unit: "gram",
                    icon: Icons.fitness_center_rounded,
                    color: AppColors.proteinColor,
                    bgColor: AppColors.proteinBg,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildNutrientCard(
                    title: "Lemak",
                    value: apiResponse.fat.replaceAll("g", "").trim(),
                    unit: "gram",
                    icon: Icons.water_drop_rounded,
                    color: AppColors.fatColor,
                    bgColor: AppColors.fatBg,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildNutrientCard(
                    title: "Karbohidrat",
                    value: apiResponse.carbs.replaceAll("g", "").trim(),
                    unit: "gram",
                    icon: Icons.grain_rounded,
                    color: AppColors.carbsColor,
                    bgColor: AppColors.carbsBg,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recommendation Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
                boxShadow: AppTheme.softShadow,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.tips_and_updates_rounded, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      "Porsi makanan ini pas dikonsumsi sebagai bagian dari menu harian seimbang Anda.",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Record to Diary Button
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  final calValue = apiResponse.cal.replaceAll("kcal", "").trim();
                  EventDB.saveCatatan(id.toString(), foodName, calValue.isEmpty ? "250" : calValue);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.bookmark_add_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Catat ke Jurnal Gizi Harian",
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value.isEmpty ? "0" : value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
