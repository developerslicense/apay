bool isBlank(String? text) {
  return text?.trim().isEmpty ?? true;
}

String? getValueFromArguments(
    List<String> resultArgument,
    String key
) {
  return resultArgument
      .firstWhere((element) => element.contains(key))
      .split('=')
  [1];
}