import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onScanTap;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onScanTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 20),
      height: 72,
      decoration: AppTheme.floatingNavDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            icon: Icons.grid_view_rounded,
            label: 'Beranda',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            icon: Icons.bookmark_border_rounded,
            label: 'Catatan',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          // Center Elevated Floating Scan Button
          GestureDetector(
            onTap: onScanTap,
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF059669), Color(0xFF10B981), Color(0xFF34D399)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.4),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          _NavItem(
            icon: Icons.menu_book_rounded,
            label: 'Katalog',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavItem(
            icon: Icons.person_outline_rounded,
            label: 'Profil',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppTheme.primaryGreen : AppTheme.textSub;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryExtraLight : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
