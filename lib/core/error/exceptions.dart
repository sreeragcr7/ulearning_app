abstract class TExceptions implements Exception {
  const TExceptions(this.message);

  final String message;
}

final class ServerExceptions extends TExceptions {
  const ServerExceptions(super.message);
}

final class AuthExceptions extends TExceptions {
  const AuthExceptions(super.message);
}

final class CacheExceptions extends TExceptions {
  const CacheExceptions(super.message);
}