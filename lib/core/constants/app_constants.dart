class AppConstants {
  static const String appName = 'RegizAI';
  static const String appVersion = '2.0.0';
  
  // Storage Keys
  static const String prefUserKey = 'user_data';
  static const String prefJournalKey = 'journal_logs';
  static const String prefThemeKey = 'is_dark_mode';
  static const String prefFirstRunKey = 'is_first_run';

  // FatSecret API OAuth 2.0 Credentials
  static const String fatSecretClientId = 'd5e5b11a9f484be4b3443ac10b9154cf';
  // Client Secret dapat diisi di sini atau melalui AppConfig
  static const String fatSecretClientSecret = '';
  static const String fatSecretTokenUrl = 'https://oauth.fatsecret.com/connect/token';
  static const String fatSecretApiUrl = 'https://platform.fatsecret.com/rest/server.api';

  // Default Nutrition Targets
  static const double defaultCalorieTarget = 2150.0;
  static const double defaultCarbTarget = 275.0;
  static const double defaultProteinTarget = 95.0;
  static const double defaultFatTarget = 65.0;

  // Assets
  static const String logoPath = 'assets/images/logo.png';
  static const String defaultAvatar = 'assets/images/avatar_placeholder.png';
}
