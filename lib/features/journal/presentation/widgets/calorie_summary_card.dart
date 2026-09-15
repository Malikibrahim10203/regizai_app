import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/journal/presentation/widgets/circular_calorie_ring.dart';

class CalorieSummaryCard extends StatelessWidget {
  final double consumed;
  final double target;
  final double carbCurrent;
  final double carbTarget;
  final double proteinCurrent;
  final double proteinTarget;
  final double fatCurrent;
  final double fatTarget;

  const CalorieSummaryCard({
    super.key,
    required this.consumed,
    required this.target,
    this.carbCurrent = 145,
    this.carbTarget = 275,
    this.proteinCurrent = 62,
    this.proteinTarget = 95,
    this.fatCurrent = 32,
    this.fatTarget = 65,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: AppTheme.emeraldHeroGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3D065F46),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Calorie Ring
              CircularCalorieRing(
                consumed: consumed,
                target: target,
                size: 130,
              ),
              const SizedBox(width: 20),
              // Target Info & Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.local_fire_department_rounded, color: Color(0xFFFDE047), size: 14),
                          SizedBox(width: 4),
                          Text(
                            'Target Kalori Harian',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${target.toInt()} kkal',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      consumed > target
                          ? 'Melebihi target harian'
                          : 'Progres tercapai ${((consumed / target) * 100).toInt()}%',
                      style: const TextStyle(
                        color: Color(0xFFD1FAE5),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // 3 Vibrant Macro Nutrient Pills
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MacroPill(
                  label: 'Karbo',
                  current: carbCurrent,
                  target: carbTarget,
                  dotColor: const Color(0xFF60A5FA), // Soft Electric Blue
                ),
                Container(height: 28, width: 1, color: Colors.white.withValues(alpha: 0.2)),
                _MacroPill(
                  label: 'Protein',
                  current: proteinCurrent,
                  target: proteinTarget,
                  dotColor: const Color(0xFF34D399), // Bright Emerald
                ),
                Container(height: 28, width: 1, color: Colors.white.withValues(alpha: 0.2)),
                _MacroPill(
                  label: 'Lemak',
                  current: fatCurrent,
                  target: fatTarget,
                  dotColor: const Color(0xFFFB7185), // Soft Rose Coral
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MacroPill extends StatelessWidget {
  final String label;
  final double current;
  final double target;
  final Color dotColor;

  const _MacroPill({
    required this.label,
    required this.current,
    required this.target,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: dotColor.withValues(alpha: 0.6),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '${current.toInt()}/${target.toInt()}g',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
