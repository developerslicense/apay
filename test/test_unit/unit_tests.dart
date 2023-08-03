import 'test_for_data/get_number_cleared_tests.dart';
import 'test_for_data/get_number_cleared_with_max_size_tests.dart';
import 'test_for_data/mask_formatter_tests.dart';
import 'test_for_data/money_tests.dart';
import 'test_for_parsing_argument_on_start/test_parsing.dart';

void unitTests() {
  testParsing();
  testsGetNumberClearedWithMaxSize();
  testsGetNumberCleared();
  testInitMoney();
  testMaskFormatter();
}