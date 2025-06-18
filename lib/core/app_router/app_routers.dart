import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/units/presentation/manager/cubit/unit_cubit.dart';
import 'package:quizly_app/features/units/presentation/views/units_view.dart';

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
          return BlocProvider.value(
            value:  SetupSeviceLocator.sl<UnitsCubit>()..fetchUnits(),
            child: UnitsView(),
          );
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
