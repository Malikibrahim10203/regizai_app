class ApiResponse {
  final String brand_name;
  final String protein;
  final String fat;
  final String carbs;
  final String cal;

  ApiResponse({
    required this.brand_name,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.cal,

  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      brand_name: json['brand_name'],
      protein: json['protein'],
      fat: json['fat'],
      carbs: json['carbs'],
      cal: json['cal'],
    );
  }
}
