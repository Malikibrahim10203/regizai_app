import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:regizai/camera/camera.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';
// imports removed
import 'package:regizai/pages/food.dart';

class Catatan extends StatefulWidget {
  const Catatan({Key? key, required this.id}) : super(key: key);
  final dynamic id;

  @override
  State<Catatan> createState() => _CatatanState();
}

class _CatatanState extends State<Catatan> {
  @override
  void initState() {
    super.initState();
    context.read<JournalBloc>().add(LoadJournalEvent(widget.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Jurnal Gizi Harian"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppColors.textPrimary),
            onPressed: () {
              context.read<JournalBloc>().add(LoadJournalEvent(widget.id.toString()));
            },
            tooltip: "Muat Ulang",
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<JournalBloc, JournalState>(
          builder: (context, state) {
            if (state is JournalLoadingState) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            final logs = state is JournalLoadedState ? state.logs : [];
            final totalCalories = state is JournalLoadedState ? state.todayCalories : 0;

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context.read<JournalBloc>().add(LoadJournalEvent(widget.id.toString()));
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                children: [
                  // Summary Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: AppTheme.coloredShadow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Asupan Gizi",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "$totalCalories",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "kcal terkumpul",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${logs.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Menu",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Riwayat Makanan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  if (logs.isEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                      child: Center(
                        child: Column(
                          children: const [
                            Icon(Icons.notes_rounded, size: 64, color: AppColors.textMuted),
                            SizedBox(height: 14),
                            Text(
                              "Belum Ada Catatan Gizi",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Pindai makanan dengan kamera atau buka buku gizi untuk mencatat makanan hari ini.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: logs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = logs[index];
                        final imgName = item.namaMakanan.toLowerCase();
                        return Dismissible(
                          key: Key(item.idCapture),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26),
                          ),
                          onDismissed: (_) {
                            context.read<JournalBloc>().add(
                                  DeleteMealLogEvent(
                                    idCapture: item.idCapture,
                                    userId: widget.id.toString(),
                                  ),
                                );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: AppColors.border),
                              boxShadow: AppTheme.softShadow,
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => Foods(nameFood: item.namaMakanan)),
                                );
                              },
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    "assets/img/$imgName.png",
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.fastfood_rounded,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                item.namaMakanan,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  const Icon(Icons.access_time_rounded, size: 12, color: AppColors.textMuted),
                                  const SizedBox(width: 4),
                                  Text(
                                    item.tglCapture,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.calorieBg,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "${item.cal} kcal",
                                      style: const TextStyle(
                                        color: AppColors.calorieColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, color: AppColors.textMuted, size: 20),
                                    onPressed: () {
                                      context.read<JournalBloc>().add(
                                            DeleteMealLogEvent(
                                              idCapture: item.idCapture,
                                              userId: widget.id.toString(),
                                            ),
                                          );
                                    },
                                    tooltip: "Hapus",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          try {
            final cameras = await availableCameras();
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Camera(cameras: cameras)),
              );
            }
          } catch (_) {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Camera(cameras: [])),
              );
            }
          }
        },
        icon: const Icon(Icons.camera_alt_rounded, color: Colors.white),
        label: const Text("Scan Makanan Baru", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
