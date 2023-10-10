import 'package:go_router/go_router.dart';

import '../../view/pages/home_page.dart';
import '../../view/template/scaffold_template.dart';

interface class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (_, state, child) => ScaffoldTemplate(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const HomePage(),
          ),
        ],
      ),
    ],
  );
}
