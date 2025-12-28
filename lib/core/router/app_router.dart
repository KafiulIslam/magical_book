import 'package:go_router/go_router.dart';
import 'package:magical_book/core/router/routes.dart';
import '../../features/arabic/presentation/views/arabic_page.dart';
import '../../features/bangla/presentation/views/bangla_page.dart';
import '../../features/dashboard/presentation/views/dashboard_page.dart';
import '../../features/english/presentation/views/english_page.dart';
import '../../features/math/presentation/views/math_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    initialLocation: Routes.dashboard,
    redirect: (context, state) {
      //! Uncomment the following lines if you want to redirect to login if access token is not present
      // if (!AppSharedPreferences.sharedPreferences
      //     .containsKey(AppStrings.accessToken)) {
      //   return Routes.userLogin;
      // }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.dashboard,
        // name: 'dashboard',
        redirect: (context, state) => Routes.bangla,
      ),
      ShellRoute(
        builder: (context, state, child) {
          return DashboardPage(child: child);
        },
        routes: [
          GoRoute(
            path: Routes.bangla,
            builder: (context, state) => const BanglaPage(),
          ),
          GoRoute(
            path: Routes.english,
            builder: (context, state) => const EnglishPage(),
          ),
          GoRoute(
            path: Routes.math,
            builder: (context, state) => const MathPage(),
          ),
          GoRoute(
            path: Routes.arabic,
            builder: (context, state) => const ArabicPage(),
          ),
        ],
      ),
    ],
  );
}
