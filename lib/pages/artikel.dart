import 'package:flutter/material.dart';
import 'package:regizai/mock/mock_data.dart';
import 'package:regizai/theme/app_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Artikel extends StatefulWidget {
  const Artikel({Key? key}) : super(key: key);

  @override
  State<Artikel> createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {
  late YoutubePlayerController _ytController;
  int _selectedArticleIndex = 0;

  @override
  void initState() {
    super.initState();
    _ytController = YoutubePlayerController(
      initialVideoId: MockData.articles[0].youtubeVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  void _selectArticle(int index) {
    setState(() {
      _selectedArticleIndex = index;
    });
    _ytController.load(MockData.articles[index].youtubeVideoId);
  }

  @override
  Widget build(BuildContext context) {
    final article = MockData.articles[_selectedArticleIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Edukasi & Artikel Gizi"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Article Selector Chips
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: MockData.articles.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedArticleIndex == index;
                  return InkWell(
                    onTap: () => _selectArticle(index),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                        boxShadow: isSelected ? AppTheme.coloredShadow : null,
                      ),
                      child: Center(
                        child: Text(
                          MockData.articles[index].category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Hero Article Banner
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppTheme.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          article.image,
                          width: double.infinity,
                          height: 190,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 14,
                          left: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              article.category,
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_outlined, color: Colors.white, size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  article.readTime,
                                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article.subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: AppColors.border),
                        const SizedBox(height: 14),
                        Text(
                          article.content,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Video Tutorial Section
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppTheme.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.video_library_rounded, color: Color(0xFFEF4444), size: 22),
                      SizedBox(width: 8),
                      Text(
                        "Video Edukasi Gizi & Diet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Simak panduan video praktis menyiapkan piring nutrisi seimbang.",
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: YoutubePlayer(
                      controller: _ytController,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: AppColors.primary,
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(isExpanded: true),
                        RemainingDuration(),
                        FullScreenButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
