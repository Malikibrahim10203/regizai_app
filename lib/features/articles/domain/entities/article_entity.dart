import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String category;
  final String readTime;
  final String content;
  final String youtubeVideoId;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.category,
    required this.readTime,
    required this.content,
    required this.youtubeVideoId,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        image,
        category,
        readTime,
        content,
        youtubeVideoId,
      ];
}
