class Regex {
  static const numberCleanEn = "[^0-9.]";
  static const numberCleanRu = "[^0-9,.]";
  // static const emailValidation = r'^[^@]+@[^@]+\.[^@]+';
  static const emailValidation = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
}
