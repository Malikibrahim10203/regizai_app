enum Environment { dev, staging, prod }

class AppConfig {
  final Environment environment;
  final String appTitle;
  final String apiBaseUrl;
  final bool isOfflineMock;

  const AppConfig({
    required this.environment,
    required this.appTitle,
    required this.apiBaseUrl,
    this.isOfflineMock = true,
  });

  static late AppConfig _instance;
  static AppConfig get instance => _instance;

  static void init({
    Environment environment = Environment.dev,
    String appTitle = 'RegizAI',
    String apiBaseUrl = 'https://api.regizai.com/v1',
    bool isOfflineMock = true,
  }) {
    _instance = AppConfig(
      environment: environment,
      appTitle: appTitle,
      apiBaseUrl: apiBaseUrl,
      isOfflineMock: isOfflineMock,
    );
  }
}
