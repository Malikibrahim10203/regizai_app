import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:regizai/app/config/app_config.dart';
import 'package:regizai/core/di/injection_container.dart' as di;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('AppConfig and DI initialization test', () async {
    SharedPreferences.setMockInitialValues({});
    AppConfig.init(
      environment: Environment.dev,
      appTitle: 'RegizAI',
      isOfflineMock: true,
    );

    expect(AppConfig.instance.appTitle, 'RegizAI');
    expect(AppConfig.instance.isOfflineMock, true);

    await di.init();
    expect(di.sl.isRegistered<SharedPreferences>(), true);
  });
}
