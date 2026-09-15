import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/bmi/presentation/widgets/bmi_gauge_widget.dart';

class BmiResultPage extends StatelessWidget {
  final double bmi;
  final String category;
  final String recommendation;

  const BmiResultPage({
    Key? key,
    required this.bmi,
    required this.category,
    required this.recommendation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Analisis IMT')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BmiGaugeWidget(bmi: bmi, category: category),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.modernCardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rekomendasi Ahli Gizi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    recommendation,
                    style: const TextStyle(fontSize: 14, height: 1.5, color: AppTheme.textSub),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hitung Ulang'),
            ),
          ],
        ),
      ),
    );
  }
}
