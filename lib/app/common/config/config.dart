enum Environment { production, development }

final class Config {
  static late Environment currentEnvironment;

  static String get apiBaseUrl {
    switch (currentEnvironment) {
      case Environment.production:
        return 'https://api.coinranking.com/v2/coins';
      case Environment.development:
        return 'https://api.coinranking.com/v2/coins';
    }
  }

  static String get environmentName {
    switch (currentEnvironment) {
      case Environment.production:
        return 'Production';
      case Environment.development:
        return 'Development';
    }
  }
}
