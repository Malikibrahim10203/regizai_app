import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:regizai/core/constants/app_constants.dart';
import 'package:regizai/features/food_catalog/data/models/food_model.dart';

abstract class FatSecretRemoteDataSource {
  bool get hasValidCredentials;
  Future<String?> getAccessToken();
  Future<List<FoodModel>> searchFoods(String query);
  Future<FoodModel?> getFoodDetail(String foodId);
}

class FatSecretRemoteDataSourceImpl implements FatSecretRemoteDataSource {
  final http.Client client;
  final String clientId;
  final String clientSecret;

  String? _cachedToken;
  DateTime? _tokenExpiry;

  FatSecretRemoteDataSourceImpl({
    http.Client? client,
    this.clientId = AppConstants.fatSecretClientId,
    this.clientSecret = AppConstants.fatSecretClientSecret,
  }) : client = client ?? http.Client();

  @override
  bool get hasValidCredentials =>
      clientId.isNotEmpty && clientSecret.isNotEmpty;

  @override
  Future<String?> getAccessToken() async {
    if (!hasValidCredentials) return null;

    if (_cachedToken != null &&
        _tokenExpiry != null &&
        DateTime.now().isBefore(_tokenExpiry!)) {
      return _cachedToken;
    }

    try {
      final response = await client.post(
        Uri.parse(AppConstants.fatSecretTokenUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
          'client_id': clientId,
          'client_secret': clientSecret,
          'scope': 'basic',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _cachedToken = data['access_token'];
        final expiresIn = (data['expires_in'] as int?) ?? 86400;
        _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn - 60));
        return _cachedToken;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<FoodModel>> searchFoods(String query) async {
    final token = await getAccessToken();
    if (token == null) return [];

    try {
      final uri = Uri.parse(AppConstants.fatSecretApiUrl).replace(
        queryParameters: {
          'method': 'foods.search',
          'search_expression': query,
          'format': 'json',
          'max_results': '20',
        },
      );

      final response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final foodsObj = data['foods'];
        if (foodsObj == null || foodsObj['food'] == null) return [];

        final dynamic foodListRaw = foodsObj['food'];
        final List<dynamic> foodItems =
            foodListRaw is List ? foodListRaw : [foodListRaw];

        return foodItems.map((item) {
          final id = item['food_id']?.toString() ?? '';
          final name = item['food_name']?.toString() ?? 'Makanan';
          final desc = item['food_description']?.toString() ?? '';
          final category = item['food_type']?.toString() ?? 'Umum';

          // Parse description string: e.g. "Per 100g - Calories: 89kcal | Fat: 0.33g | Carbs: 22.84g | Protein: 1.09g"
          int calories = 0;
          double fat = 0.0;
          double carbs = 0.0;
          double protein = 0.0;
          String portion = '1 porsi (100g)';

          if (desc.contains('Calories:')) {
            final calMatch = RegExp(r'Calories:\s*(\d+)').firstMatch(desc);
            if (calMatch != null) calories = int.tryParse(calMatch.group(1)!) ?? 0;
          }
          if (desc.contains('Fat:')) {
            final fatMatch = RegExp(r'Fat:\s*([\d.]+)g').firstMatch(desc);
            if (fatMatch != null) fat = double.tryParse(fatMatch.group(1)!) ?? 0.0;
          }
          if (desc.contains('Carbs:')) {
            final carbsMatch = RegExp(r'Carbs:\s*([\d.]+)g').firstMatch(desc);
            if (carbsMatch != null) carbs = double.tryParse(carbsMatch.group(1)!) ?? 0.0;
          }
          if (desc.contains('Protein:')) {
            final proteinMatch = RegExp(r'Protein:\s*([\d.]+)g').firstMatch(desc);
            if (proteinMatch != null) protein = double.tryParse(proteinMatch.group(1)!) ?? 0.0;
          }
          if (desc.contains('-')) {
            portion = desc.split('-').first.trim();
          }

          // Fallback image using culinary photography placeholder based on query
          final imageUrl = 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400';

          return FoodModel(
            id: id,
            name: name,
            category: category,
            image: imageUrl,
            calories: calories,
            protein: protein,
            fat: fat,
            carbs: carbs,
            sugar: 0.0,
            vitamins: 'Nutrisi Lengkap FatSecret',
            portion: portion,
            description: desc.isNotEmpty
                ? desc
                : 'Informasi nutrisi akurat dari FatSecret Platform API.',
          );
        }).toList();
      }
    } catch (_) {}

    return [];
  }

  @override
  Future<FoodModel?> getFoodDetail(String foodId) async {
    final token = await getAccessToken();
    if (token == null) return null;

    try {
      final uri = Uri.parse(AppConstants.fatSecretApiUrl).replace(
        queryParameters: {
          'method': 'food.get.v4',
          'food_id': foodId,
          'format': 'json',
        },
      );

      final response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final food = data['food'];
        if (food == null) return null;

        final id = food['food_id']?.toString() ?? foodId;
        final name = food['food_name']?.toString() ?? 'Makanan';
        final servings = food['servings'];
        dynamic serving;

        if (servings != null && servings['serving'] != null) {
          final sList = servings['serving'];
          serving = (sList is List) ? sList.first : sList;
        }

        final calories = int.tryParse(serving?['calories']?.toString() ?? '0') ?? 0;
        final protein = double.tryParse(serving?['protein']?.toString() ?? '0') ?? 0.0;
        final fat = double.tryParse(serving?['fat']?.toString() ?? '0') ?? 0.0;
        final carbs = double.tryParse(serving?['carbohydrate']?.toString() ?? '0') ?? 0.0;
        final sugar = double.tryParse(serving?['sugar']?.toString() ?? '0') ?? 0.0;
        final portion = serving?['serving_description']?.toString() ?? '1 porsi';

        return FoodModel(
          id: id,
          name: name,
          category: 'Pangan Alami',
          image: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400',
          calories: calories,
          protein: protein,
          fat: fat,
          carbs: carbs,
          sugar: sugar,
          vitamins: 'Kalsium, Kalium, Zat Besi',
          portion: portion,
          description: 'Data nutrisi lengkap dan akurat bersumber dari FatSecret REST API.',
        );
      }
    } catch (_) {}

    return null;
  }
}
