import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:magical_book/core/router/routes.dart';
import 'package:magical_book/features/bangla/presentation/views/chora_screen.dart';
import '../../features/arabic/presentation/views/arabic_page.dart';
import '../../features/bangla/presentation/views/bangla_page.dart';
import '../../features/bangla/presentation/views/borno_mala_screen.dart';
import '../../features/bangla/presentation/views/bangla_fruit_screen.dart';
import '../../features/bangla/presentation/views/bangla_flower_screen.dart';
import '../../features/bangla/presentation/views/bangla_season_screen.dart';
import '../../features/bangla/presentation/views/bangla_month_screen.dart';
import '../../features/bangla/presentation/views/bangla_day_screen.dart';
import '../../features/dashboard/presentation/views/dashboard_page.dart';
import '../../features/english/presentation/views/english_page.dart';
import '../../features/english/presentation/views/english_alphabet_screen.dart';
import '../../features/english/presentation/views/english_rhymes_screen.dart';
import '../../features/english/presentation/views/english_fruit_screen.dart';
import '../../features/english/presentation/views/english_flower_screen.dart';
import '../../features/english/presentation/views/english_body_part_screen.dart';
import '../../features/english/presentation/views/english_day_screen.dart';
import '../../features/english/presentation/views/english_month_screen.dart';
import '../../features/english/presentation/views/english_animal_screen.dart';
import '../../features/english/presentation/views/english_bird_screen.dart';
import '../../features/math/presentation/views/math_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  /// Helper method to create a fade transition page
  static Page<dynamic> fadeTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

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
              routes: [
                GoRoute(
                  path: '/borno-mala',
                  pageBuilder: (context, state) => fadeTransitionPage(
                    state: state,
                    child: const BornoMalaScreen(),
                  ),
                ),
                GoRoute(
                  path: '/chora',
                  pageBuilder: (context, state) => fadeTransitionPage(
                    state: state,
                    child: const ChoraScreen(),
                  ),
                ),
                GoRoute(
                  path: '/foler-nam',
                  pageBuilder: (context, state) => fadeTransitionPage(
                    state: state,
                    child: const BanglaFruitScreen(),
                  ),
                ),
                GoRoute(
                  path: '/fuler-nam',
                  pageBuilder: (context, state) => fadeTransitionPage(
                    state: state,
                    child: const BanglaFlowerScreen(),
                  ),
                ),
                GoRoute(
                  path: '/ritur-nam',
                  pageBuilder: (context, state) => fadeTransitionPage(
                    state: state,
                    child: const BanglaSeasonScreen(),
                  ),
                ),
                GoRoute(
                  path: '/maser-nam',
                  pageBuilder: (context, state) => fadeTransitionPage(
                    state: state,
                    child: const BanglaMonthScreen(),
                  ),
                ),
                GoRoute(
                  path: '/diner-nam',
                  pageBuilder: (context, state) => fadeTransitionPage(
                    state: state,
                    child: const BanglaDayScreen(),
                  ),
                ),
              ]),
          GoRoute(
            path: Routes.english,
            builder: (context, state) => const EnglishPage(),
            routes: [
              GoRoute(
                path: '/alphabet',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishAlphabetScreen(),
                ),
              ),
              GoRoute(
                path: '/rhymes',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishRhymesScreen(),
                ),
              ),
              GoRoute(
                path: '/fruits',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishFruitScreen(),
                ),
              ),
              GoRoute(
                path: '/flowers',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishFlowerScreen(),
                ),
              ),
              GoRoute(
                path: '/body-parts',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishBodyPartScreen(),
                ),
              ),
              GoRoute(
                path: '/days',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishDayScreen(),
                ),
              ),
              GoRoute(
                path: '/months',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishMonthScreen(),
                ),
              ),
              GoRoute(
                path: '/animals',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishAnimalScreen(),
                ),
              ),
              GoRoute(
                path: '/birds',
                pageBuilder: (context, state) => fadeTransitionPage(
                  state: state,
                  child: const EnglishBirdScreen(),
                ),
              ),
            ],
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
