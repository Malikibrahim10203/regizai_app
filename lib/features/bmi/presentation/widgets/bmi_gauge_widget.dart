import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';

class BmiGaugeWidget extends StatelessWidget {
  final double bmi;
  final String category;

  const BmiGaugeWidget({Key? key, required this.bmi, required this.category}) : super(key: key);

  Color _getColor() {
    if (bmi < 18.5) return AppTheme.carbColor;
    if (bmi <= 24.9) return AppTheme.primaryGreen;
    if (bmi <= 29.9) return AppTheme.calorieColor;
    return AppTheme.fatColor;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.modernCardDecoration(),
      child: Column(
        children: [
          Text(
            bmi.toStringAsFixed(1),
            style: TextStyle(fontSize: 54, fontWeight: FontWeight.w900, color: color),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
