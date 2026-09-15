import 'dart:convert';
import 'package:http/http.dart' as http;

class MyFitnessPalService {
  static const String apiUrl = 'https://myfitnesspal2.p.rapidapi.com';
  static const String apiKey = 'ead0414182mshac3f188039aca36p15e194jsnc0f9137c6639';

  Future<dynamic> fetchNutritionData(String food) async {
    List nutrition = [];
    final url = Uri.parse('$apiUrl/searchByKeyword?keyword=$food');
    final response = await http.get(url, headers: {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'myfitnesspal2.p.rapidapi.com',
    });

    var result = json.decode(response.body);
    if (food == "ayam goreng") {
      nutrition = [result[1]['nutritional_contents']['fat'],result[1]['nutritional_contents']['protein'],result[1]['nutritional_contents']['net_carbs']];
    } else {
      nutrition = [result[0]['nutritional_contents']['fat'],result[0]['nutritional_contents']['protein'],result[0]['nutritional_contents']['net_carbs']];
    }
    if (response.statusCode == 200) {
      return nutrition;
    } else {
      throw Exception('Failed to load nutrition data');
    }
  }
}
