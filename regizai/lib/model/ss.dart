class ApiResponse {
  final String prediction;
  final double confidence;
  final String imagePath;
  final String fileName;
  final String description;
  final String pengendalianHayati;
  final String pengendalianKimiawi;

  ApiResponse({
    required this.prediction,
    required this.confidence,
    required this.imagePath,
    required this.fileName,
    required this.description,
    required this.pengendalianHayati,
    required this.pengendalianKimiawi,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      prediction: json['prediction'],
      confidence: json['confidence'],
      imagePath: json['image_path'],
      fileName: json['file_name'],
      description: json['description'],
      pengendalianHayati: json['pengendalian_hayati'],
      pengendalianKimiawi: json['pengendalian_kimiawi'],
    );
  }
}
