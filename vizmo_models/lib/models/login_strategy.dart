enum LoginStrategyEnum {
  password,
  saml,
  oidc,
}

class LoginStrategy {
  final LoginStrategyEnum? strategy;
  final String? name;
  final String? url;

  LoginStrategy({
    this.strategy,
    this.name,
    this.url,
  });
}
