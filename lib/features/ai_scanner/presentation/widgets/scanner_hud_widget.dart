import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';

class ScannerHudWidget extends StatelessWidget {
  const ScannerHudWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.primaryGreen, width: 3),
          borderRadius: BorderRadius.circular(24),
          color: Colors.white.withOpacity(0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.center_focus_weak, color: AppTheme.primaryGreen, size: 48),
            SizedBox(height: 8),
            Text(
              'Arahkan kamera ke piring makanan',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
