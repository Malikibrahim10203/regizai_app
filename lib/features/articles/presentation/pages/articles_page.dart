import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/features/articles/presentation/cubit/article_cubit.dart';
import 'package:regizai/features/articles/presentation/widgets/article_card_widget.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artikel & Edukasi Gizi')),
      body: BlocBuilder<ArticleCubit, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return ArticleCardWidget(article: article);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
