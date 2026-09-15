import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/ai_scanner/presentation/bloc/scanner_bloc.dart';
import 'package:regizai/features/ai_scanner/presentation/widgets/scanner_hud_widget.dart';

class CameraScannerPage extends StatelessWidget {
  const CameraScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('AI Food Scanner', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<ScannerBloc, ScannerState>(
        listener: (context, state) {
          if (state is ScanSuccessState) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.scanPreview,
              arguments: {
                'imagePath': 'assets/images/sample_food.jpg',
                'foodName': state.result.foodName,
                'calories': double.tryParse(state.result.calories.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 420.0,
                'protein': double.tryParse(state.result.protein.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 18.5,
                'fat': double.tryParse(state.result.fat.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 12.0,
                'carbs': double.tryParse(state.result.carbs.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 55.0,
              },
            );
          } else if (state is ScanErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppTheme.fatColor),
            );
          }
        },
        builder: (context, state) {
          final isScanning = state is ScanningState;

          return Stack(
            children: [
              Container(
                color: const Color(0xFF1E293B),
                child: const Center(
                  child: Icon(Icons.fastfood, size: 120, color: Colors.white12),
                ),
              ),
              const ScannerHudWidget(),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: isScanning
                        ? null
                        : () {
                            context.read<ScannerBloc>().add(const StartScanEvent('Nasi Goreng Sehat'));
                          },
                    icon: isScanning
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Icon(Icons.camera),
                    label: Text(
                      isScanning ? 'Menganalisis Gizi AI...' : 'Ambil & Deteksi Gizi',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
