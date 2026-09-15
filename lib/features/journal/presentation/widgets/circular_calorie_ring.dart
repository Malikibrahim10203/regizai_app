import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircularCalorieRing extends StatelessWidget {
  final double consumed;
  final double target;
  final double size;

  const CircularCalorieRing({
    super.key,
    required this.consumed,
    required this.target,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (target > 0) ? (consumed / target).clamp(0.0, 1.0) : 0.0;
    final remaining = (target - consumed).clamp(0.0, double.infinity);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: progress,
              trackColor: Colors.white.withValues(alpha: 0.2),
              progressColors: [
                const Color(0xFFFDE047), // Bright Yellow
                const Color(0xFF6EE7B7), // Mint
                const Color(0xFFFFFFFF), // Pure White glow
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${consumed.toInt()}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              const Text(
                'kkal',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFD1FAE5),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Sisa ${remaining.toInt()}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final List<Color> progressColors;

  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16) / 2;
    const strokeWidth = 12.0;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Progress Arc with Sweep Gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: progressColors,
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      rect,
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
