enum AppLanguage {
  ptBr,
  enUs,
}

AppLanguage appLanguage = AppLanguage.enUs;

class AppStrings {
  const AppStrings._();

  static GenericStrings get generic => GenericStrings();

  static String placeholder = switch (appLanguage) {
    AppLanguage.ptBr => "Gaudiot Brasil",
    AppLanguage.enUs => "Gaudiot USA",
  };
}

class GenericStrings {
  String get welcome => switch (appLanguage) {
        AppLanguage.ptBr => "Bem-vindo",
        AppLanguage.enUs => "Welcome",
      };
}
