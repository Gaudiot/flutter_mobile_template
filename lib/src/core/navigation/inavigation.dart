import "package:flutter/material.dart";
import "package:flutter_mobile_template/src/base/enums/app_routes.enum.dart";
import "package:flutter_mobile_template/src/core/navigation/implementation/go_router_navigation.dart";

class HomeNavigation {}

abstract class INavigation {
  RouterConfig<Object> get routerConfig;

  void goto({
    required AppRoutes path,
    Map<String, String> pathParameters = const {},
    Object? data,
  });
  void push({
    required AppRoutes path,
    Map<String, String> pathParameters = const {},
    Object? data,
  });
  void pop();
}

class NavigationModule {
  final INavigation _navigation = GoRouterNavigation();

  void goto({
    required AppRoutes path,
    Map<String, String> pathParameters = const {},
    Object? data,
  }) {
    _navigation.goto(
      path: path,
      pathParameters: pathParameters,
      data: data,
    );
  }

  void push({
    required AppRoutes path,
    Map<String, String> pathParameters = const {},
    Object? data,
  }) {
    _navigation.push(
      path: path,
      pathParameters: pathParameters,
      data: data,
    );
  }
}

class _Navigation {
  const _Navigation();
}

const navigation = _Navigation();
