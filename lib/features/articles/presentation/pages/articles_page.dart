import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/articles/domain/entities/article_entity.dart';
import 'package:regizai/features/articles/presentation/cubit/article_cubit.dart';
import 'package:regizai/features/articles/presentation/widgets/article_card_widget.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Pola Makan',
    'Tips Diet',
    'Makronutrien',
    'Resep Sehat',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSoft,
      appBar: AppBar(
        title: const Text(
          'Artikel & Edukasi Gizi',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
      ),
      body: BlocBuilder<ArticleCubit, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoaded) {
            final allArticles = state.articles;
            final filteredArticles = _selectedCategory == 'Semua'
                ? allArticles
                : allArticles.where((a) => a.category.toLowerCase().contains(_selectedCategory.toLowerCase())).toList();

            final featuredArticle = allArticles.isNotEmpty ? allArticles.first : null;
            final otherArticles = filteredArticles.where((a) => a.id != featuredArticle?.id).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Horizontal Category Pills
                  SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected = _selectedCategory == cat;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedCategory = cat),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? AppTheme.primaryGreen : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? AppTheme.primaryGreen : AppTheme.borderSubtle,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  cat,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                    color: isSelected ? Colors.white : AppTheme.textMain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Hero Featured Article Card (Shown when 'Semua' is active)
                  if (_selectedCategory == 'Semua' && featuredArticle != null) ...[
                    const Text(
                      'Pilihan Redaksi',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                    ),
                    const SizedBox(height: 10),
                    _HeroFeaturedArticleCard(
                      article: featuredArticle,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.articleDetail, arguments: featuredArticle);
                      },
                    ),
                    const SizedBox(height: 22),
                  ],
                  // Recent Articles Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedCategory == 'Semua' ? 'Artikel Edukasi Lainnya' : 'Kategori: $_selectedCategory',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                      ),
                      Text(
                        '${otherArticles.length} Artikel',
                        style: const TextStyle(fontSize: 12, color: AppTheme.textSub, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // List of Article Cards
                  if (otherArticles.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(32),
                      alignment: Alignment.center,
                      child: Column(
                        children: const [
                          Icon(Icons.menu_book_rounded, size: 48, color: AppTheme.borderSubtle),
                          SizedBox(height: 8),
                          Text('Belum ada artikel untuk kategori ini', style: TextStyle(color: AppTheme.textSub, fontSize: 13)),
                        ],
                      ),
                    )
                  else
                    ...otherArticles.map((article) => ArticleCardWidget(
                          article: article,
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.articleDetail, arguments: article);
                          },
                        )),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(color: AppTheme.primaryGreen));
        },
      ),
    );
  }
}

class _HeroFeaturedArticleCard extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback onTap;

  const _HeroFeaturedArticleCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppTheme.bentoCardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                  child: Image.network(
                    article.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: AppTheme.primaryLight,
                      child: const Icon(Icons.menu_book_rounded, size: 60, color: AppTheme.primaryGreen),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      article.category,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined, color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          article.readTime.isNotEmpty ? article.readTime : '5 mnt baca',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textMain,
                      letterSpacing: -0.3,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.subtitle.isNotEmpty ? article.subtitle : article.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: AppTheme.textSub, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Text(
                        'Baca Artikel Lengkap',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryDark,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded, size: 16, color: AppTheme.primaryDark),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
