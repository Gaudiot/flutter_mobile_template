import "package:flutter_mobile_template/src/core/local_storage/ilocal_storage.dart";
import "package:flutter_mobile_template/src/core/local_storage/implementations/shared_preferences_storage.dart";
import "package:flutter_mobile_template/src/core/navigation/implementation/go_router_navigation.dart";
import "package:flutter_mobile_template/src/core/navigation/inavigation.dart";
import "package:get_it/get_it.dart";

final GetIt locator = GetIt.instance;

void initLocator() {
  locator.registerSingleton<ILocalStorage>(SharedPreferencesAsyncStorage());
  locator.registerSingleton<INavigation>(GoRouterNavigation());
}
