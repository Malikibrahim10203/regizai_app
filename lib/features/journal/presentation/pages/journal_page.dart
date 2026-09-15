import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Makanan')),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state is JournalLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is JournalLoadedState) {
            if (state.logs.isEmpty) {
              return const Center(
                child: Text('Belum ada catatan makanan hari ini.\nScan makanan Anda untuk menambah log!', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSub)),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: state.logs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final log = state.logs[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: AppTheme.modernCardDecoration(),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.restaurant, color: AppTheme.primaryGreen),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(log.namaMakanan, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Text('${log.cal} kkal • ${log.tglCapture}', style: const TextStyle(color: AppTheme.textSub, fontSize: 13)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppTheme.fatColor),
                        onPressed: () {
                          context.read<JournalBloc>().add(
                                DeleteMealLogEvent(idCapture: log.idCapture, userId: log.idUser),
                              );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Gagal memuat catatan makanan.'));
        },
      ),
    );
  }
}
