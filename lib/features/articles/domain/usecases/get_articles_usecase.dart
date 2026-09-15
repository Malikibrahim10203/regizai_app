import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/articles/domain/entities/article_entity.dart';
import 'package:regizai/mock/mock_data.dart';

class GetArticlesUseCase implements UseCase<List<ArticleEntity>, NoParams> {
  @override
  Future<List<ArticleEntity>> call(NoParams params) async {
    return MockData.articles
        .map(
          (a) => ArticleEntity(
            id: a.id,
            title: a.title,
            subtitle: a.subtitle,
            image: a.image,
            category: a.category,
            readTime: a.readTime,
            content: a.content,
            youtubeVideoId: a.youtubeVideoId,
          ),
        )
        .toList();
  }
}
