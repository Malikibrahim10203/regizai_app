import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/bmi/domain/entities/bmi_entity.dart';

class BmiParams {
  final double weightKg;
  final double heightCm;
  BmiParams({required this.weightKg, required this.heightCm});
}

class CalculateBmiUseCase implements UseCase<BmiEntity, BmiParams> {
  @override
  Future<BmiEntity> call(BmiParams params) async {
    final w = params.weightKg;
    final h = params.heightCm;

    if (h <= 0 || w <= 0) {
      return const BmiEntity(
        bmi: 0.0,
        status: "Tidak Valid",
        category: "Data tidak valid",
        colorHex: 0xFF94A3B8,
        idealMin: 0.0,
        idealMax: 0.0,
        advice: "Tinggi dan berat badan harus lebih dari 0.",
      );
    }

    final heightM = h / 100.0;
    final bmi = w / (heightM * heightM);
    final idealMin = 18.5 * (heightM * heightM);
    final idealMax = 24.9 * (heightM * heightM);

    String status;
    String category;
    int colorValue;
    String advice;

    if (bmi < 18.5) {
      status = 'Kurus (Underweight)';
      category = 'Berat Badan Kurang';
      colorValue = 0xFF38BDF8;
      advice = 'Tingkatkan asupan kalori bergizi dan makanan berprotein tinggi.';
    } else if (bmi <= 24.9) {
      status = 'Normal (Ideal)';
      category = 'Berat Badan Sehat';
      colorValue = 0xFF10B981;
      advice = 'Pertahankan pola makan seimbang dan aktivitas fisik teratur.';
    } else if (bmi <= 29.9) {
      status = 'Gemuk (Overweight)';
      category = 'Kelebihan Berat Badan';
      colorValue = 0xFFF59E0B;
      advice = 'Kurangi makanan tinggi gula/lemak dan rutin berolahraga.';
    } else {
      status = 'Obesitas';
      category = 'Risiko Tinggi';
      colorValue = 0xFFEF4444;
      advice = 'Konsultasikan dengan dokter untuk program diet terarah.';
    }

    return BmiEntity(
      bmi: double.parse(bmi.toStringAsFixed(1)),
      status: status,
      category: category,
      colorHex: colorValue,
      idealMin: double.parse(idealMin.toStringAsFixed(1)),
      idealMax: double.parse(idealMax.toStringAsFixed(1)),
      advice: advice,
    );
  }
}
