import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/articles/domain/entities/article_entity.dart';

class ArticleCardWidget extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback? onTap;

  const ArticleCardWidget({super.key, required this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: AppTheme.bentoCardDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Fixed aspect-ratio rounded thumbnail with centered crop
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 104,
                height: 84,
                child: Image.network(
                  article.image,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppTheme.primaryLight,
                    child: const Icon(Icons.menu_book_rounded, color: AppTheme.primaryGreen, size: 32),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: Text(
                          article.category,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF047857),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '⏱️ ${article.readTime.isNotEmpty ? article.readTime : "5 mnt"}',
                        style: const TextStyle(fontSize: 10, color: AppTheme.textSub, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textMain,
                      height: 1.3,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.subtitle.isNotEmpty ? article.subtitle : article.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: AppTheme.textSub),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded, color: AppTheme.textSub, size: 20),
          ],
        ),
      ),
    );
  }
}
