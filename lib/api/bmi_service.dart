import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BmiService {
  static const String _baseUrl = 'https://body-mass-index-bmi-calculator.p.rapidapi.com/metric';
  static const String _apiKey = '1a918cc994msh68ae3bd669dbe12p10ad09jsn61c8f959d258';  // Replace with your RapidAPI key

  Future<Map<String, dynamic>> calculateBmi(double weight, double height) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?weight=$weight&height=$height'),
      headers: {
        'Content-Type': 'application/json',
        'X-RapidAPI-Host': 'body-mass-index-bmi-calculator.p.rapidapi.com',
        'X-RapidAPI-Key': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to calculate BMI');
    }
  }
}