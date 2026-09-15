import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';

class CalorieSummaryCard extends StatelessWidget {
  final double consumed;
  final double target;

  const CalorieSummaryCard({
    Key? key,
    required this.consumed,
    required this.target,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remaining = (target - consumed).clamp(0, double.infinity);
    final progress = (target > 0) ? (consumed / target).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.heroGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3310B981),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kebutuhan Kalori Harian', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${consumed.toInt()} kkal', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800)),
              Text('Target: ${target.toInt()} kkal', style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 10),
          Text('Tersisa: ${remaining.toInt()} kkal', style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }
}
