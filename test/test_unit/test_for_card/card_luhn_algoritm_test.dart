import 'package:apay/data/utils/card_utils/card_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void testLuhnAlgorithm() {
  test('тест getMoneyCleared', (){
    // success
    expect(_validateCardNumWithLuhnAlgorithm("6250941006528599"), true);
    expect(_validateCardNumWithLuhnAlgorithm("60115564485789458"), true);
    expect(_validateCardNumWithLuhnAlgorithm("6011000991300009"), true);
    expect(_validateCardNumWithLuhnAlgorithm("5425233430109903"), true);
    expect(_validateCardNumWithLuhnAlgorithm("2222420000001113"), true);
    expect(_validateCardNumWithLuhnAlgorithm("4263982640269299"), true);
    expect(_validateCardNumWithLuhnAlgorithm("4917484589897107"), true);
    expect(_validateCardNumWithLuhnAlgorithm("4001919257537193"), true);
    expect(_validateCardNumWithLuhnAlgorithm("411111111111111"), false);
    expect(_validateCardNumWithLuhnAlgorithm("5392150002388575"), true);

    // failure
    expect(_validateCardNumWithLuhnAlgorithm("378282246310005"), false);
    expect(_validateCardNumWithLuhnAlgorithm("411111111111112"), false);
    expect(_validateCardNumWithLuhnAlgorithm("411111111111113"), false);
    expect(_validateCardNumWithLuhnAlgorithm("5392250002388575"), false);
    expect(_validateCardNumWithLuhnAlgorithm("5392150502388575"), false);
    expect(_validateCardNumWithLuhnAlgorithm("5392150002318575"), false);
    expect(_validateCardNumWithLuhnAlgorithm("5392150802388575"), false);
  });
}

bool _validateCardNumWithLuhnAlgorithm(String? number) {
  return validateCardNumWithLuhnAlgorithm(number);
}