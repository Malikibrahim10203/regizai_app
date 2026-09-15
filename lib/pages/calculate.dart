import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';
import 'package:regizai/features/bmi/presentation/cubit/bmi_cubit.dart';

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final _weightController = TextEditingController(text: "65");
  final _heightController = TextEditingController(text: "170");

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthenticatedState) {
      final user = authState.user;
      if (user.width.isNotEmpty) _weightController.text = user.width;
      if (user.height.isNotEmpty) _heightController.text = user.height;
    }
    _computeBmi();
  }

  void _computeBmi() {
    final w = double.tryParse(_weightController.text) ?? 0.0;
    final h = double.tryParse(_heightController.text) ?? 0.0;
    if (w > 0 && h > 0) {
      context.read<BmiCubit>().calculate(w, h);
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Kalkulator BMI"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            const Text(
              "Indeks Massa Tubuh (BMI)",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Ketahui status berat badan dan kisaran ideal tubuh Anda.",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppTheme.softShadow,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Berat Badan",
                            hintText: "Contoh: 65",
                            prefixIcon: Icon(Icons.monitor_weight_outlined),
                          ),
                          onChanged: (_) => _computeBmi(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            "Kg",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Tinggi Badan",
                            hintText: "Contoh: 170",
                            prefixIcon: Icon(Icons.height_rounded),
                          ),
                          onChanged: (_) => _computeBmi(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            "Cm",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: AppTheme.coloredShadow,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: _computeBmi,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.refresh_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Hitung Ulang Status BMI",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            BlocBuilder<BmiCubit, BmiState>(
              builder: (context, state) {
                if (state is BmiCalculatedState) {
                  final bmi = state.bmiData;
                  final statusColor = Color(bmi.colorHex);

                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: AppTheme.softShadow,
                      border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Skor BMI Anda",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${bmi.bmi}",
                          style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                            color: statusColor,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            bmi.status,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Row(
                                children: [
                                  Expanded(child: Container(height: 8, color: const Color(0xFF38BDF8))),
                                  Expanded(child: Container(height: 8, color: const Color(0xFF10B981))),
                                  Expanded(child: Container(height: 8, color: const Color(0xFFF59E0B))),
                                  Expanded(child: Container(height: 8, color: const Color(0xFFEF4444))),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("< 18.5", style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                                Text("18.5 - 24.9", style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                                Text("25 - 29.9", style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                                Text(">= 30", style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.health_and_safety_outlined, color: AppColors.primary, size: 24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Kisaran Berat Badan Ideal Anda:",
                                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "${bmi.idealMin} kg - ${bmi.idealMax} kg",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          bmi.advice,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
