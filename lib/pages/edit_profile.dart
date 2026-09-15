import 'package:flutter/material.dart';
import 'package:regizai/event/event_db.dart';
import 'package:regizai/theme/app_theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
    required this.id,
    required this.name,
    required this.width,
    required this.height,
  });

  final dynamic id;
  final dynamic name;
  final dynamic width;
  final dynamic height;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controllerName;
  late TextEditingController _controllerOldPassword;
  late TextEditingController _controllerNewPassword;
  late TextEditingController _controllerWidth;
  late TextEditingController _controllerHeight;

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController(text: widget.name?.toString() ?? "");
    _controllerOldPassword = TextEditingController();
    _controllerNewPassword = TextEditingController();
    _controllerWidth = TextEditingController(text: widget.width?.toString() ?? "");
    _controllerHeight = TextEditingController(text: widget.height?.toString() ?? "");
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerOldPassword.dispose();
    _controllerNewPassword.dispose();
    _controllerWidth.dispose();
    _controllerHeight.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await EventDB.editUser(
      widget.id.toString(),
      _controllerName.text.trim(),
      _controllerOldPassword.text,
      _controllerNewPassword.text,
      _controllerWidth.text.trim(),
      _controllerHeight.text.trim(),
    );

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Edit Profil Pengguna"),
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
                // Avatar Header
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.softShadow,
                      border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
                    ),
                    child: Image.asset("assets/img/male.png", fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 24),

                // Form Card
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppTheme.softShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Informasi Pribadi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name
                      TextFormField(
                        controller: _controllerName,
                        decoration: const InputDecoration(
                          labelText: "Nama Lengkap",
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) return "Nama tidak boleh kosong";
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Weight and Height
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _controllerWidth,
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _controllerHeight,
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
                      const SizedBox(height: 24),

                      const Divider(color: AppColors.border),
                      const SizedBox(height: 16),

                      const Text(
                        "Ubah Kata Sandi (Opsional)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Kosongkan jika Anda tidak ingin mengubah kata sandi.",
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 16),

                      // Old Password
                      TextFormField(
                        controller: _controllerOldPassword,
                        obscureText: _obscureOld,
                        decoration: InputDecoration(
                          labelText: "Kata Sandi Lama",
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureOld ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                            onPressed: () => setState(() => _obscureOld = !_obscureOld),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // New Password
                      TextFormField(
                        controller: _controllerNewPassword,
                        obscureText: _obscureNew,
                        decoration: InputDecoration(
                          labelText: "Kata Sandi Baru",
                          prefixIcon: const Icon(Icons.vpn_key_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureNew ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                            onPressed: () => setState(() => _obscureNew = !_obscureNew),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Save Button
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
                    onPressed: _isLoading ? null : _handleSave,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.save_rounded, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "Simpan Perubahan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
