import "package:flutter/material.dart";
import "package:flutter_mobile_template/src/base/enums/app_routes.enum.dart";
import "package:flutter_mobile_template/src/core/navigation/inavigation.dart";
import "package:go_router/go_router.dart";

class GoRouterNavigation implements INavigation {
  @override
  void goto({
    required AppRoutes path,
    Map<String, String> pathParameters = const {},
    Object? data,
  }) {
    routerConfig.goNamed(
      path.name,
      pathParameters: pathParameters,
      extra: data,
    );
  }

  @override
  void push({
    required AppRoutes path,
    Map<String, String> pathParameters = const {},
    Object? data,
  }) {
    routerConfig.pushNamed(
      path.name,
      pathParameters: pathParameters,
      extra: data,
    );
  }

  @override
  void pop() {
    routerConfig.pop();
  }

  @override
  GoRouter get routerConfig => GoRouter(
        initialLocation: AppRoutes.home.path,
        routes: [
          GoRoute(
            name: AppRoutes.home.name,
            path: AppRoutes.home.path,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      );
}
