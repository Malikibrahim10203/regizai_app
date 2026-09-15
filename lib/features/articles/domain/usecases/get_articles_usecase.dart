import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/articles/domain/entities/article_entity.dart';

class GetArticlesUseCase implements UseCase<List<ArticleEntity>, NoParams> {
  static const List<ArticleEntity> _mockArticles = [
    ArticleEntity(
      id: '1',
      title: 'Pentingnya Sarapan Sehat dengan Gizi Seimbang',
      subtitle: 'Memulai hari dengan nutrisi yang tepat',
      image: 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=800&h=450&fit=crop&crop=entropy&auto=format&q=80',
      category: 'Pola Makan',
      readTime: '4 menit baca',
      content: 'Sarapan bergizi seimbang memberikan energi esensial bagi tubuh dan otak untuk beraktivitas optimal sepanjang hari. Pastikan sarapan Anda memadukan karbohidrat kompleks, protein berkualitas, dan serat alami dari buah atau sayuran.',
      youtubeVideoId: 'dQw4w9WgXcQ',
    ),
    ArticleEntity(
      id: '2',
      title: 'Pedoman Gizi Seimbang: Isi Piringku Kemenkes RI',
      subtitle: 'Panduan porsi makan harian sehat & proporsional',
      image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&h=450&fit=crop&crop=entropy&auto=format&q=80',
      category: 'Tips Diet',
      readTime: '5 menit baca',
      content: 'Kemenkes RI merekomendasikan pembagian porsi makan: sepertiga piring berisi makanan pokok berkarbohidrat, sepertiga piring aneka sayuran segar, seperenam buah-buahan, dan seperenam lauk pauk kaya protein.',
      youtubeVideoId: '',
    ),
    ArticleEntity(
      id: '3',
      title: 'Manfaat Hidrasi dan Konsumsi Air Putih Cukup',
      subtitle: 'Jaga metabolisme tubuh bekerja maksimal',
      image: 'https://images.unsplash.com/photo-1523362628745-0c100150b504?w=800&h=450&fit=crop&crop=entropy&auto=format&q=80',
      category: 'Hidrasi',
      readTime: '3 menit baca',
      content: 'Konsumsi minimal 8 gelas atau 2 liter air setiap hari sangat krusial untuk menjaga fungsi ginjal, melancarkan sirkulasi nutrisi, serta mencegah rasa lelah akibat dehidrasi ringan.',
      youtubeVideoId: '',
    ),
    ArticleEntity(
      id: '4',
      title: 'Peran Krusial Protein dalam Pembentukan Otot',
      subtitle: 'Mempercepat regenerasi sel dan daya tahan tubuh',
      image: 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=800&h=450&fit=crop&crop=entropy&auto=format&q=80',
      category: 'Makronutrien',
      readTime: '6 menit baca',
      content: 'Protein merupakan fondasi utama penyusun sel otot dan enzim tubuh. Konsumsi protein dari sumber hewani dan nabati seperti telur, dada ayam, ikan, tahu, dan tempe sangat disarankan.',
      youtubeVideoId: '',
    ),
    ArticleEntity(
      id: '5',
      title: 'Khasiat Buah dan Serat untuk Kesehatan Pencernaan',
      subtitle: 'Detoksifikasi alami dan kontrol kadar gula darah',
      image: 'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=800&h=450&fit=crop&crop=entropy&auto=format&q=80',
      category: 'Resep Sehat',
      readTime: '4 menit baca',
      content: 'Serat larut dan tak larut dari buah segar membantu menjaga flora usus baik, mencegah sembelit, serta menstabilkan penyerapan gula dan kolesterol dalam darah.',
      youtubeVideoId: '',
    ),
  ];

  @override
  Future<List<ArticleEntity>> call(NoParams params) async {
    return _mockArticles;
  }
}
