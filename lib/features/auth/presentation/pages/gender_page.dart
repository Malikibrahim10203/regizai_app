import 'package:flutter/material.dart';
import 'package:regizai/app/config/routes/app_routes.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String _selectedGender = 'Laki-laki';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Jenis Kelamin')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Pilih Jenis Kelamin Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ListTile(
              title: const Text('Laki-laki'),
              leading: Radio<String>(
                value: 'Laki-laki',
                groupValue: _selectedGender,
                onChanged: (v) => setState(() => _selectedGender = v!),
              ),
            ),
            ListTile(
              title: const Text('Perempuan'),
              leading: Radio<String>(
                value: 'Perempuan',
                groupValue: _selectedGender,
                onChanged: (v) => setState(() => _selectedGender = v!),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.biodata);
              },
              child: const Text('Lanjut'),
            ),
          ],
        ),
      ),
    );
  }
}
