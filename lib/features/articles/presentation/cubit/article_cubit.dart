import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/articles/domain/entities/article_entity.dart';
import 'package:regizai/features/articles/domain/usecases/get_articles_usecase.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
  @override
  List<Object?> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<ArticleEntity> articles;
  final int selectedIndex;
  const ArticleLoaded({required this.articles, this.selectedIndex = 0});

  ArticleEntity get currentArticle => articles[selectedIndex];

  @override
  List<Object?> get props => [articles, selectedIndex];
}

class ArticleCubit extends Cubit<ArticleState> {
  final GetArticlesUseCase getArticlesUseCase;

  ArticleCubit(this.getArticlesUseCase) : super(ArticleInitial());

  void loadArticles() async {
    final list = await getArticlesUseCase(NoParams());
    emit(ArticleLoaded(articles: list, selectedIndex: 0));
  }

  void selectArticle(int index) {
    if (state is ArticleLoaded) {
      final cur = state as ArticleLoaded;
      emit(ArticleLoaded(articles: cur.articles, selectedIndex: index));
    }
  }
}
