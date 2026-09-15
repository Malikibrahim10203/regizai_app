import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _heightController;
  late TextEditingController _widthController;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    final user = (authState is AuthenticatedState) ? authState.user : null;
    _nameController = TextEditingController(text: user?.name ?? '');
    _heightController = TextEditingController(text: user?.height ?? '170');
    _widthController = TextEditingController(text: user?.width ?? '65');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Tinggi Badan (cm)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _widthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Berat Badan (kg)', border: OutlineInputBorder()),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final authState = context.read<AuthBloc>().state;
                  final userId = (authState is AuthenticatedState) ? authState.user.id : 'user_01';

                  context.read<AuthBloc>().add(
                        UpdateProfileEvent(
                          id: userId,
                          name: _nameController.text.trim(),
                          oldPassword: '',
                          newPassword: '',
                          width: _widthController.text.trim(),
                          height: _heightController.text.trim(),
                        ),
                      );
                  Navigator.pop(context);
                },
                child: const Text('Simpan Perubahan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
