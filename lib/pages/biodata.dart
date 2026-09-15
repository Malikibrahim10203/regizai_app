import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';
import 'package:regizai/pages/dashboard.dart';

class Biodata extends StatefulWidget {
  const Biodata({
    super.key,
    required this.email,
    required this.password,
    required this.gender,
  });

  final String email;
  final String password;
  final String gender;

  @override
  State<Biodata> createState() => _BiodataState();
}

class _BiodataState extends State<Biodata> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedBirthDate = DateTime(2000, 1, 1);
  final _nameController = TextEditingController();
  final _birthController = TextEditingController(text: "2000-01-01");
  final _weightController = TextEditingController(text: "65");
  final _heightController = TextEditingController(text: "170");

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedBirthDate = picked;
        _birthController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
          SignUpEvent(
            name: _nameController.text.trim(),
            email: widget.email,
            password: widget.password,
            gender: widget.gender,
            birth: _birthController.text,
            width: _weightController.text.trim(),
            height: _heightController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Akun berhasil dibuat! Selamat datang di Regizai."),
                  backgroundColor: AppColors.accentMint,
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Dashboard()),
                (route) => false,
              );
            } else if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoadingState;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Langkah 3 dari 3 • Biodata Fisik",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Lengkapi Biodata Anda",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 28),

                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: AppTheme.softShadow,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: "Nama Lengkap",
                              hintText: "Contoh: Budi Santoso",
                              prefixIcon: Icon(Icons.person_outline_rounded),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) return "Nama lengkap wajib diisi";
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            controller: _birthController,
                            readOnly: true,
                            onTap: _pickDate,
                            decoration: InputDecoration(
                              labelText: "Tanggal Lahir",
                              prefixIcon: const Icon(Icons.calendar_today_outlined),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.edit_calendar_rounded, color: AppColors.primary),
                                onPressed: _pickDate,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _weightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Berat (Kg)",
                                    prefixIcon: Icon(Icons.monitor_weight_outlined),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) return "Wajib diisi";
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: TextFormField(
                                  controller: _heightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Tinggi (Cm)",
                                    prefixIcon: Icon(Icons.height_rounded),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) return "Wajib diisi";
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),

                          Container(
                            height: 52,
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: isLoading ? null : _handleSubmit,
                              child: isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          "Selesaikan Pendaftaran",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
