import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/articles/domain/entities/article_entity.dart';

class GetArticlesUseCase implements UseCase<List<ArticleEntity>, NoParams> {
  static const List<ArticleEntity> _mockArticles = [
    ArticleEntity(
      id: '1',
      title: 'Pentingnya Sarapan Sehat dengan Gizi Seimbang',
      subtitle: 'Memulai hari dengan nutrisi yang tepat',
      image: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=400',
      category: 'Tips Gizi',
      readTime: '4 menit baca',
      content: 'Sarapan bergizi seimbang memberikan energi esensial bagi tubuh dan otak untuk beraktivitas optimal sepanjang hari.',
      youtubeVideoId: 'dQw4w9WgXcQ',
    ),
    ArticleEntity(
      id: '2',
      title: 'Pedoman Gizi Seimbang: Isi Piringku Kemenkes RI',
      subtitle: 'Panduan porsi makan harian sehat',
      image: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=400',
      category: 'Panduan Kesehatan',
      readTime: '5 menit baca',
      content: 'Kemenkes merekomendasikan pembagian piring makan: 1/3 karbohidrat, 1/3 sayuran, 1/6 buah-buahan, dan 1/6 lauk pauk protein.',
      youtubeVideoId: '',
    ),
    ArticleEntity(
      id: '3',
      title: 'Manfaat Hidrasi dan Konsumsi Air Putih Cukup',
      subtitle: 'Jaga metabolisme tubuh bekerja maksimal',
      image: 'https://images.unsplash.com/photo-1548839140-29a749e1bc4e?w=400',
      category: 'Hidrasi',
      readTime: '3 menit baca',
      content: 'Konsumsi minimal 8 gelas atau 2 liter air setiap hari sangat krusial untuk menjaga fungsi ginjal dan hidrasi sel.',
      youtubeVideoId: '',
    ),
  ];

  @override
  Future<List<ArticleEntity>> call(NoParams params) async {
    return _mockArticles;
  }
}
