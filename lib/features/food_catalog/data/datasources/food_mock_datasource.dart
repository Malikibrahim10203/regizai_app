import 'package:regizai/features/food_catalog/data/models/food_model.dart';

abstract class FoodMockDataSource {
  Future<List<FoodModel>> getFoods();
}

class FoodMockDataSourceImpl implements FoodMockDataSource {
  static const List<FoodModel> _mockFoods = [
    FoodModel(
      id: '1',
      name: 'Nasi Merah',
      category: 'Karbohidrat',
      image: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
      calories: 215,
      protein: 5.0,
      fat: 1.6,
      carbs: 45.0,
      sugar: 0.7,
      vitamins: 'Vitamin B1, B3, B6, Magnesium',
      portion: '1 porsi (200 gr)',
      description: 'Nasi merah mengandung serat tinggi dan indeks glikemik rendah, sangat baik untuk menjaga kestabilan gula darah.',
    ),
    FoodModel(
      id: '2',
      name: 'Dada Ayam Panggang',
      category: 'Protein',
      image: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=400',
      calories: 165,
      protein: 31.0,
      fat: 3.6,
      carbs: 0.0,
      sugar: 0.0,
      vitamins: 'Vitamin B6, B12, Niacin, Fosfor',
      portion: '100 gr',
      description: 'Dada ayam tanpa kulit merupakan sumber protein hewani berkualitas tinggi tanpa lemak berlebih.',
    ),
    FoodModel(
      id: '3',
      name: 'Salmon Panggang',
      category: 'Protein',
      image: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400',
      calories: 206,
      protein: 22.0,
      fat: 12.0,
      carbs: 0.0,
      sugar: 0.0,
      vitamins: 'Vitamin D, B12, Omega-3',
      portion: '100 gr',
      description: 'Ikan salmon kaya akan asam lemak omega-3 yang mendukung kesehatan jantung dan fungsi kognitif otak.',
    ),
    FoodModel(
      id: '4',
      name: 'Sayur Bayam Bening',
      category: 'Sayuran',
      image: 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400',
      calories: 45,
      protein: 3.0,
      fat: 0.5,
      carbs: 7.0,
      sugar: 0.8,
      vitamins: 'Zat Besi, Vitamin A, Vitamin C, Kalsium',
      portion: '1 mangkuk',
      description: 'Bayam kaya akan antioksidan, zat besi pencegah anemia, dan serat untuk kesehatan pencernaan.',
    ),
    FoodModel(
      id: '5',
      name: 'Tempe Bacem Bakar',
      category: 'Protein Nabati',
      image: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400',
      calories: 195,
      protein: 19.0,
      fat: 11.0,
      carbs: 9.0,
      sugar: 2.0,
      vitamins: 'Isoflavon, Kalsium, Zat Besi, Probiotik',
      portion: '2 potong (100 gr)',
      description: 'Tempe fermentasi adalah makanan super khas Indonesia yang kaya prebiotik dan protein nabati.',
    ),
    FoodModel(
      id: '6',
      name: 'Alpukat Mentega',
      category: 'Buah',
      image: 'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?w=400',
      calories: 160,
      protein: 2.0,
      fat: 15.0,
      carbs: 8.5,
      sugar: 0.7,
      vitamins: 'Vitamin E, Kalium, Folat',
      portion: '1 buah sedang (100 gr)',
      description: 'Alpukat adalah buah dengan lemak tak jenuh tunggal yang membantu menurunkan kadar kolesterol jahat (LDL).',
    ),
  ];

  @override
  Future<List<FoodModel>> getFoods() async {
    return _mockFoods;
  }
}
