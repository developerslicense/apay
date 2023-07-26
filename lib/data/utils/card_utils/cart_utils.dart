import '../number_clearer_utils.dart';
import 'card_type.dart';

// https://en.wikipedia.org/wiki/Payment_card_number

CardType getCardTypeFrmNumber(String input) {
  CardType cardType;
  if (input.startsWith(RegExp(r'((34)|(37))'))) {
    cardType = CardType.americanExpress;

  } else if (input.startsWith(RegExp(r'(62)'))) {
    cardType = CardType.chinaUnionPay;

  } else if (input.startsWith(RegExp(r'(220[0–4])'))) {
    cardType = CardType.mir;

  } else if (input.startsWith(RegExp(r'((5018)|(5020)|(5038)|(5893)|(6304)|(6759)|(6761)|(6762)|(6763))'))) {
    cardType = CardType.maestro;

  } else if (input.startsWith(RegExp(r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
    cardType = CardType.masterCard;

  } else if (input.startsWith(RegExp(r'4'))) {
    cardType = CardType.visa;

  } else {
    cardType = CardType.invalid;
  }
  return cardType;
}

bool validateCardNumWithLuhnAlgorithm(String? number) {
  var input = getNumberCleared(number);
  if ((input.length) < 16) {
    return false;
  }

  int sum = 0;
  int length = input.length;

  for (var i = 0; i < length; i++) {
    // get digits in reverse order

    int digit = int.parse(input[length - i - 1] ?? '');

    // every 2nd number multiply with 2
    if (i % 2 == 1) {
      digit *= 2;
    }

    sum += digit > 9 ? (digit - 9) : digit;
  }

  return (sum % 10 == 0);
}