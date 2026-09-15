import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:regizai/core/constants/app_constants.dart';
import 'package:regizai/features/food_catalog/data/models/food_model.dart';

abstract class FatSecretRemoteDataSource {
  bool get hasValidCredentials;
  Future<List<FoodModel>> searchFoods(String query);
  Future<FoodModel?> getFoodDetail(String foodId);
}

class FatSecretRemoteDataSourceImpl implements FatSecretRemoteDataSource {
  final http.Client client;
  final String consumerKey;
  final String consumerSecret;

  FatSecretRemoteDataSourceImpl({
    http.Client? client,
    this.consumerKey = AppConstants.fatSecretConsumerKey,
    this.consumerSecret = AppConstants.fatSecretConsumerSecret,
  }) : client = client ?? http.Client();

  @override
  bool get hasValidCredentials =>
      consumerKey.isNotEmpty && consumerSecret.isNotEmpty;

  String _signRequest(String method, String url, Map<String, String> params) {
    // 1. Sort parameters alphabetically
    final sortedKeys = params.keys.toList()..sort();
    final paramPairs = sortedKeys.map((k) {
      final keyEncoded = Uri.encodeQueryComponent(k);
      final valueEncoded = Uri.encodeQueryComponent(params[k] ?? '');
      return '$keyEncoded=$valueEncoded';
    }).join('&');

    // 2. Form signature base string
    final baseString = '$method&'
        '${Uri.encodeQueryComponent(url)}&'
        '${Uri.encodeQueryComponent(paramPairs)}';

    // 3. Generate HMAC-SHA1 signature
    final signingKey = utf8.encode('${Uri.encodeQueryComponent(consumerSecret)}&');
    final hmacSha1 = Hmac(sha1, signingKey);
    final digest = hmacSha1.convert(utf8.encode(baseString));

    return base64.encode(digest.bytes);
  }

  Uri _buildSignedUri(Map<String, String> requestParams) {
    final now = DateTime.now().toUtc();
    final timestamp = (now.millisecondsSinceEpoch ~/ 1000).toString();
    final nonce = now.microsecondsSinceEpoch.toString();

    final allParams = <String, String>{
      ...requestParams,
      'format': 'json',
      'oauth_consumer_key': consumerKey,
      'oauth_nonce': nonce,
      'oauth_signature_method': 'HMAC-SHA1',
      'oauth_timestamp': timestamp,
      'oauth_version': '1.0',
    };

    final signature = _signRequest('GET', AppConstants.fatSecretApiUrl, allParams);
    allParams['oauth_signature'] = signature;

    return Uri.parse(AppConstants.fatSecretApiUrl).replace(queryParameters: allParams);
  }

  String _getFoodImage(String foodName) {
    final lower = foodName.toLowerCase();
    if (lower.contains('apple') || lower.contains('apel')) {
      return 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400';
    } else if (lower.contains('banana') || lower.contains('pisang')) {
      return 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400';
    } else if (lower.contains('rice') || lower.contains('nasi')) {
      return 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400';
    } else if (lower.contains('chicken') || lower.contains('ayam')) {
      return 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=400';
    } else if (lower.contains('egg') || lower.contains('telur')) {
      return 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=400';
    } else if (lower.contains('salmon') || lower.contains('ikan')) {
      return 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400';
    } else if (lower.contains('salad') || lower.contains('sayur')) {
      return 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400';
    } else if (lower.contains('milk') || lower.contains('susu')) {
      return 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400';
    }
    return 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400';
  }

  @override
  Future<List<FoodModel>> searchFoods(String query) async {
    if (!hasValidCredentials) return [];

    try {
      final signedUri = _buildSignedUri({
        'method': 'foods.search',
        'search_expression': query,
        'max_results': '25',
      });

      final response = await client.get(signedUri);

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

          // Example desc: "Per 100g - Calories: 52kcal | Fat: 0.17g | Carbs: 13.81g | Protein: 0.26g"
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

          return FoodModel(
            id: id,
            name: name,
            category: category,
            image: _getFoodImage(name),
            calories: calories,
            protein: protein,
            fat: fat,
            carbs: carbs,
            sugar: 0.0,
            vitamins: 'Nutrisi Resmi FatSecret',
            portion: portion,
            description: desc.isNotEmpty ? desc : 'Informasi nutrisi resmi FatSecret.',
          );
        }).toList();
      }
    } catch (_) {}

    return [];
  }

  @override
  Future<FoodModel?> getFoodDetail(String foodId) async {
    if (!hasValidCredentials) return null;

    try {
      final signedUri = _buildSignedUri({
        'method': 'food.get.v2',
        'food_id': foodId,
      });

      final response = await client.get(signedUri);

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
        final portion = serving?['serving_description']?.toString() ??
            serving?['measurement_description']?.toString() ??
            '1 porsi';

        final calcium = serving?['calcium']?.toString();
        final iron = serving?['iron']?.toString();
        final fiber = serving?['fiber']?.toString();
        final vitaminsList = <String>[];
        if (fiber != null) vitaminsList.add('Serat ${fiber}g');
        if (calcium != null) vitaminsList.add('Kalsium $calcium%');
        if (iron != null) vitaminsList.add('Zat Besi $iron%');

        return FoodModel(
          id: id,
          name: name,
          category: 'Pangan Alami',
          image: _getFoodImage(name),
          calories: calories,
          protein: protein,
          fat: fat,
          carbs: carbs,
          sugar: sugar,
          vitamins: vitaminsList.isNotEmpty ? vitaminsList.join(', ') : 'Gizi Seimbang',
          portion: portion,
          description: 'Data nutrisi lengkap dan resmi bersumber langsung dari FatSecret Platform API.',
        );
      }
    } catch (_) {}

    return null;
  }
}
