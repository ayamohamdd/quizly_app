import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/features/units/presentation/units_view.dart';

class AppRouter {
  // static const String splashView = '/';
  static const String mainNavigationView = '/main';
  static const String unitView = '/';

  static final appRouter = GoRouter(
    initialLocation: unitView,
    routes: [
     

      GoRoute(
        path: unitView,
        builder: (context, state) {
          return UnitsView();
        },
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
  );
}
