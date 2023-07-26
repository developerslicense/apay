bool isDateValid(String? value) {

  if (value?.isEmpty == true
      || value == null
      || value.startsWith('00')) {
    return false;
  }

  int? year;
  int? month;
  // The value contains a forward slash if the month and year has been
  // entered.
  if (value.contains(RegExp(r'(\/)'))) {

    var split = value.split(RegExp(r'(\/)'));
    // The value before the slash is the month while the value to right of
    // it is the year.
    try {
      month = int.parse(split[0]);
    } catch (e) {
      month = -1;
    }
    try {
      year = int.parse(split[1]);
    } catch (e) {
      year = 0;
    }

  } else { // Only the month was entered
    month = int.parse(value.substring(0, (value.length)));
    year = -1; // Lets use an invalid year intentionally
  }

  if ((month < 1) || (month > 12)) {
    // A valid month is between 1 (January) and 12 (December)
    return false;
  }

  var fourDigitsYear = _convertYearTo4Digits(year);
  if ((fourDigitsYear < 2010) || (fourDigitsYear > 2099)) {

    // We are assuming a valid year should be between 1 and 2099.
    // Note that, it's valid doesn't mean that it has not expired.
    return false;
  }

  return _isNotExpired(year, month);
}


bool _isNotExpired(int? year, int? month) {
  return !_hasYearExpired(year) && !_hasMonthExpired(year, month);
}


bool _hasMonthExpired(int? year, int? month) {
  var now = DateTime.now();
  // The month has passed if:
  // 1. The year is in the past. In that case, we just assume that the month
  // has passed
  // 2. Card's month (plus another month) is less than current month.
  return _hasYearExpired(year) ||
    _convertYearTo4Digits(year) == now.year && ((month ?? 1) < now.month);
}

bool _hasYearExpired(int? year) {
  int fourDigitsYear = _convertYearTo4Digits(year);
  var now = DateTime.now();
  // The year has passed if the year we are currently, is greater than card's
  // year
  return fourDigitsYear < now.year;
}

/// Convert the two-digit year to four-digit year if necessary
int _convertYearTo4Digits(int? year) {
  if ((year ?? 0) < 100 && (year ?? 0) >= 0) {
    var now = DateTime.now();
    String currentYear = now.year.toString();
    String prefix = currentYear.substring(0, currentYear.length - 2);
    year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
  }
  return year ?? 0;
}
