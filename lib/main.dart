import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:smart_sight/core/router/app_router.dart';

Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

Future<void> main() async {
  await _configureMacosWindowUtils();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosApp.router(
      title: 'Smart Sight',
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
