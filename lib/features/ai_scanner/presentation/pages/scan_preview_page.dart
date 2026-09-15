import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';

class ScanPreviewPage extends StatelessWidget {
  final String imagePath;
  final String foodName;
  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  const ScanPreviewPage({
    Key? key,
    required this.imagePath,
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Deteksi AI')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Icon(Icons.check_circle_outline_rounded, size: 80, color: AppTheme.primaryGreen),
              ),
            ),
            const SizedBox(height: 24),
            Text(foodName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
            const SizedBox(height: 6),
            const Text('Terdeteksi oleh RegizAI Vision Engine', style: TextStyle(color: AppTheme.textSub)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.modernCardDecoration(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Kalori', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${calories.toInt()} kkal', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.calorieColor)),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _MacroInfo(label: 'Protein', value: '${protein.toInt()}g', color: AppTheme.proteinColor),
                      _MacroInfo(label: 'Lemak', value: '${fat.toInt()}g', color: AppTheme.fatColor),
                      _MacroInfo(label: 'Karbohidrat', value: '${carbs.toInt()}g', color: AppTheme.carbColor),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.bookmark_add_outlined),
              label: const Text('Simpan ke Catatan Harian'),
              onPressed: () {
                context.read<JournalBloc>().add(
                      AddMealLogEvent(
                        userId: 'user_01',
                        namaMakanan: foodName,
                        cal: calories.toInt().toString(),
                      ),
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil disimpan ke catatan makanan!'), backgroundColor: AppTheme.primaryGreen),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroInfo extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MacroInfo({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSub)),
      ],
    );
  }
}
