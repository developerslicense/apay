import 'package:apay/data/utils/base_strings.dart';
import 'package:apay/data/utils/money_utlis.dart';
import 'package:flutter_test/flutter_test.dart';

void testInitMoney() {
  test('test Money', () {
    expect(_initMoneyAmountMoney(_initMoney(0)), 0);
    expect(_initMoneyAmountMoney(_initMoney(123)), 123);
    expect(_initMoneyAmountMoney(_initMoney(012)), 12);
    expect(_initMoneyAmountMoney(_initMoney(012)).toString(), '12');
    expect(_initMoneyAmountMoney(_initMoney(0012)), 12);
    expect(_initMoneyAmountMoney(_initMoney(000012)), 12);
    expect(_initMoneyAmountMoney(_initMoney(000012)).toString(), '12');
    expect(_initMoneyAmountMoney(_initMoney(0000120)), 120);
    expect(_initMoneyAmountMoney(_initMoney(00001020)), 1020);
    expect(_initMoneyAmountMoney(_initMoney(5123)), 5123);
    expect(_initMoneyAmountMoney(_initMoney(123456)), 123456);
    expect(_initMoneyAmountMoney(_initMoney(1234567890)), 1234567890);
    expect(_initMoneyAmountMoney(_initMoney(12345678901234)), 1234567890);

    expect(_initMoneyAmountInt(0), 0);
    expect(_initMoneyAmountInt(123), 123);
    expect(_initMoneyAmountInt(012), 12);
    expect(_initMoneyAmountInt(00012), 12);
    expect(_initMoneyAmountInt(0000012), 12);
    expect(_initMoneyAmountInt(5123), 5123);
    expect(_initMoneyAmountInt(123456), 123456);
    expect(_initMoneyAmountInt(1234567890), 1234567890);
    expect(_initMoneyAmountInt(12345678901234), 1234567890);

    expect(_initMoneyAmountDouble(0), 0);
    expect(_initMoneyAmountDouble(123.0), 123);
    expect(_initMoneyAmountDouble(0.0), 0);
    expect(_initMoneyAmountDouble(00.0), 0);
    expect(_initMoneyAmountDouble(0000.0), 0);
    expect(_initMoneyAmountDouble(0.12), 0);
    expect(_initMoneyAmountDouble(00.12), 0);
    expect(_initMoneyAmountDouble(0000.12), 0);
    expect(_initMoneyAmountDouble(0000.1200), 0);
    expect(_initMoneyAmountDouble(5.123), 5);
    expect(_initMoneyAmountDouble(6.1234), 6);
    expect(_initMoneyAmountDouble(123456.1234), 123456);
    expect(_initMoneyAmountDouble(12345678.1234), 12345678);
    expect(_initMoneyAmountDouble(1234567890.1234), 1234567890);


    expect(_initMoneyAmountString('0'), 0);
    expect(_initMoneyAmountString('123'), 123);
    expect(_initMoneyAmountString('012'), 12);
    expect(_initMoneyAmountString('012').toString(), '12');
    expect(_initMoneyAmountString('000012').toString(), '12');
    expect(_initMoneyAmountString('0040012').toString(), '40012');
    expect(_initMoneyAmountString('5123'), 5123);
    expect(_initMoneyAmountString('123456'), 123456);
    expect(_initMoneyAmountString('1234567890'), 1234567890);
    expect(_initMoneyAmountString('12345678901234'), 1234567890);
    expect(_initMoneyAmountString('0'), 0);
    expect(_initMoneyAmountString('123.0'), 123);
    expect(_initMoneyAmountString('0.0'), 0);
    expect(_initMoneyAmountString('0.12'), 0);
    expect(_initMoneyAmountString('5.123'), 5);
    expect(_initMoneyAmountString('6.1234'), 6);
    expect(_initMoneyAmountString('123456.1234'), 123456);
    expect(_initMoneyAmountString('12345678.1234'), 12345678);
    expect(_initMoneyAmountString('1234567890.1234'), 1234567890);
    expect(_initMoneyAmountString('0ds&#\$%!'), 0);
    expect(_initMoneyAmountString('ds&#\$%!1ds&#\$%!23ds&#\$%!'), 123);
    expect(_initMoneyAmountString('0ds&#\$%!12ds&#\$%!'), 12);
    expect(_initMoneyAmountString('012ds&#\$%!').toString(), '12');
    expect(_initMoneyAmountString('0000ds&#\$%!12').toString(), '12');
    expect(_initMoneyAmountString('004ds&#\$%!0012').toString(), '40012');
    expect(_initMoneyAmountString('5ds&#\$%!123'), 5123);
    expect(_initMoneyAmountString('123456vds&#\$%!'), 123456);
    expect(_initMoneyAmountString('1ds&#\$%!234567890'), 1234567890);
    expect(_initMoneyAmountString('ds&#\$%!12345678ds&#\$%!901234'), 1234567890);
    expect(_initMoneyAmountString('0'), 0);
    expect(_initMoneyAmountString('1ds&#\$%!23.0'), 123);
    expect(_initMoneyAmountString('ds&#\$%!0.0ds&#\$%!'), 0);
    expect(_initMoneyAmountString('ds&#\$%!0.12'), 0);
    expect(_initMoneyAmountString('5.12ds&#\$%!3'), 5);
    expect(_initMoneyAmountString('ds&#\$%!6.1234'), 6);
    expect(_initMoneyAmountString('ds&#\$%!12ds&#\$%!3456.1234'), 123456);
    expect(_initMoneyAmountString('ds&#\$%!1234567ds&#\$%!8.1234'), 12345678);
    expect(_initMoneyAmountString('ds&#\$%!12345678ds&#\$%!90.1234'), 1234567890);


    expect(_getMoneyFormatted('0'), '0 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('123'), '123 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('012'), '12 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('012').toString(), '12 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('000012').toString(), '12 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('0040012').toString(), '40 012 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('5123'), '5 123 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('123456'), '123 456 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('1234567890'), '1 234 567 890 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('12345678901234'), '1 234 567 890 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('123.0'), '123 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('0.0'), '0 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('0.12'), '0 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('5.123'), '5 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('6.1234'), '6 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('123456.1234'), '123 456 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('12345678.1234'), '12 345 678 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('1234567890.1234'), '1 234 567 890 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('0ds&#\$%!'), '0 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('ds&#\$%!1ds&#\$%!23ds&#\$%!'), '123 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('0ds&#\$%!12ds&#\$%!'), '12 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('012ds&#\$%!').toString(), '12 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('0000ds&#\$%!12').toString(), '12 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('004ds&#\$%!0012').toString(), '40 012 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('5ds&#\$%!123'), '5 123 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('123456vds&#\$%!'), '123 456 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('1ds&#\$%!234567890'), '1 234 567 890 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('ds&#\$%!12345678ds&#\$%!901234'), '1 234 567 890 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('1ds&#\$%!23.0'), '123 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('ds&#\$%!0.0ds&#\$%!'), '0 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('ds&#\$%!0.12'), '0 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('5.12ds&#\$%!3'), '5 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('ds&#\$%!6.1234'), '6 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('ds&#\$%!12ds&#\$%!3456.1234'), '123 456 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('ds&#\$%!1234567ds&#\$%!8.1234'), '12 345 678 ${StringsBase.kzt}');
    expect(_getMoneyFormatted('ds&#\$%!12345678ds&#\$%!90.1234'), '1 234 567 890 ${StringsBase.kzt}');
  });
}

int _initMoneyAmountString(String amounts) {
  return Money.initString(amount: amounts).amount;
}

int _initMoneyAmountDouble(double amounts) {
  return Money.initDouble(amount: amounts).amount;
}

int _initMoneyAmountMoney(Money amounts) {
  return Money.initMoney(amounts).amount;
}

int _initMoneyAmountInt(int amount) {
  return Money(amount).amount;
}

Money _initMoney(int amount) {
  return Money(amount);
}

String _getMoneyFormatted(String amount) {
  return getMoneyFormatted(amount);
}
