import 'package:flutter/material.dart';
import 'package:regizai/event/event_db.dart';
import 'package:regizai/theme/app_theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "user@regizai.com");
  final _oldPassController = TextEditingController(text: "password123");
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _handleReset() async {
    if (!_formKey.currentState!.validate()) return;

    if (_newPassController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Konfirmasi kata sandi baru tidak cocok!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success = await EventDB.forgotPassword(
      _emailController.text.trim(),
      _oldPassController.text,
      _newPassController.text,
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lupa Kata Sandi"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.softShadow,
                    ),
                    child: const Icon(
                      Icons.lock_reset_rounded,
                      size: 42,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Reset Kata Sandi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Masukkan email terdaftar dan kata sandi baru Anda untuk memperbarui akses akun.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),

                // Demo hint container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.accentMintLight.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accentMint.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline_rounded, color: AppColors.accentMint, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Akun demo: user@regizai.com / password123",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF065F46),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Alamat Email",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Email wajib diisi";
                    if (!val.contains("@")) return "Format email tidak valid";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Old Password
                TextFormField(
                  controller: _oldPassController,
                  obscureText: _obscureOld,
                  decoration: InputDecoration(
                    labelText: "Kata Sandi Saat Ini",
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureOld ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscureOld = !_obscureOld),
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Kata sandi saat ini wajib diisi";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // New Password
                TextFormField(
                  controller: _newPassController,
                  obscureText: _obscureNew,
                  decoration: InputDecoration(
                    labelText: "Kata Sandi Baru",
                    prefixIcon: const Icon(Icons.vpn_key_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureNew ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscureNew = !_obscureNew),
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.length < 6) {
                      return "Kata sandi baru minimal 6 karakter";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm New Password
                TextFormField(
                  controller: _confirmPassController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: "Konfirmasi Kata Sandi Baru",
                    prefixIcon: const Icon(Icons.check_circle_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Harap konfirmasi kata sandi baru";
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Submit Button
                Container(
                  height: 52,
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
                    onPressed: _isLoading ? null : _handleReset,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Text(
                            "Perbarui Kata Sandi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
