class StringsBase {
  static const String ru = 'ru';
  static const String kz = 'kz';
  static const String en = 'en';
  static const String kzt = '₸';

  static String currentLang = ru;
}

String getStrFromRes(String ru, String kz) {
  if (StringsBase.currentLang == StringsBase.kz) {
    return kz;
  } else {
    return ru;
  }
}
