import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/features/bmi/presentation/cubit/bmi_cubit.dart';

class BmiCalculatorPage extends StatefulWidget {
  const BmiCalculatorPage({Key? key}) : super(key: key);

  @override
  State<BmiCalculatorPage> createState() => _BmiCalculatorPageState();
}

class _BmiCalculatorPageState extends State<BmiCalculatorPage> {
  final _heightController = TextEditingController(text: '170');
  final _weightController = TextEditingController(text: '65');
  String _gender = 'Laki-laki';

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BmiCubit, BmiState>(
      listener: (context, state) {
        if (state is BmiCalculatedState) {
          Navigator.pushNamed(
            context,
            AppRoutes.bmiResult,
            arguments: {
              'bmi': state.bmiData.bmi,
              'category': state.bmiData.category,
              'recommendation': state.bmiData.advice,
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Kalkulator Indeks Massa Tubuh (IMT)')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Laki-laki')),
                      selected: _gender == 'Laki-laki',
                      onSelected: (_) => setState(() => _gender = 'Laki-laki'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Perempuan')),
                      selected: _gender == 'Perempuan',
                      onSelected: (_) => setState(() => _gender = 'Perempuan'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Tinggi Badan (cm)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Berat Badan (kg)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  final h = double.tryParse(_heightController.text) ?? 170.0;
                  final w = double.tryParse(_weightController.text) ?? 65.0;
                  context.read<BmiCubit>().calculate(w, h);
                },
                child: const Text('Hitung Status Gizi Saya'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
