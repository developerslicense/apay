import '../utils/base_strings.dart';

// эти исключения из-за того, что в enum используются
const String tryAgainRu = 'Попробовать снова';
const String tryAgainKz = 'Қайтадан байқап көріңіз';

const String payAnotherCardRu = 'Оплатить другой картой';
const String payAnotherCardKz = 'Басқа картамен төлеңіз';

const String goToMarketRu = 'Вернуться в магазин';
const String goToMarketKz = 'Дүкенге оралу';

const String limitExceededRu = 'Превышен лимит \nпо карте';
const String limitExceededKz = 'Карта шегінен \nасып кетті';

const String tryPayAnotherCardRu = 'Попробуйте оплатить другой картой';
const String tryPayAnotherCardKz = 'Басқа картамен төлеуге тырысыңыз';

const String kzt = '₸';

String paymentByCard() { return getStrFromRes('Оплата картой', 'Карточка арқылы төлеу'); }
String paymentByCard2() { return getStrFromRes('Оплатить картой', 'Картамен төлеу'); }


String paymentOfPurchase() {
  return getStrFromRes('Оплата покупки', 'Сатып алу төлемі');
}

String amountOfPurchase() {
  return getStrFromRes('Сумма покупки', 'Сатып алу сомасы');
}

String numberOfPurchase() {
  return getStrFromRes('Номер заказа', 'Тапсырыс нөмірі');
}

String holderName() {
  return getStrFromRes('Имя держателя', 'Ұстаушы аты');
}

String cardNumber() {
  return getStrFromRes('Номер карты', 'Карта нөмірі');
}

String dateExpired() {
  return getStrFromRes('ММ/ГГ', 'АА/ЖЖ');
}

String cvv() {
  return getStrFromRes('CVV', 'CVV');
}

String saveCardData() {
  return getStrFromRes('Сохранить данные карты', 'Карта мәліметтерін сақтаңыз');
}

String sendCheckToEmail() {
  return getStrFromRes('Отправить чек на e-mail', 'Чекті электрондық поштаға жіберіңіз');
}

String email() {
  return getStrFromRes('E-mail', 'E-mail');
}

String payAmount() {
  return getStrFromRes('Оплатить', 'Төлеу');
}

String cvvInfo() {
  return getStrFromRes('CVV находится на задней стороне вашей платежной карты', 'CVV төлем картаңыздың артында орналасқан');
}

String cardDataSaved() {
  return getStrFromRes('Данные карты сохранены', 'Карта деректері сақталды');
}

String needFillTheField() {
  return getStrFromRes('Заполните поле', 'Өрісті толтырыңыз');
}

String wrongDate() {
  return getStrFromRes('Неверная дата', 'Қате күн');
}

String wrongEmail() {
  return getStrFromRes('Неверный емейл', 'Жарамсыз электрондық пошта');
}

String wrongCvv() {
  return getStrFromRes('Неверный CVV', 'Жарамсыз CVV');
}

String wrongCardNumber() {
  return getStrFromRes('Неправильный номер карты', 'Карта нөмірі қате');
}

String yes() {
  return getStrFromRes('Да', 'Иә');
}
String no() {
  return getStrFromRes('Нет', 'Жоқ');
}

String dropPayment() {
  return getStrFromRes('Прервать оплату?', 'Төлемді тоқтату керек пе?');
}

String paySuccess() {
  return getStrFromRes('Оплата прошла успешно', 'Төлем сәтті болды');
}

String goToMarker() {
  return getStrFromRes(goToMarketRu, goToMarketKz);
}

String dropPaymentDescription() {
  return getStrFromRes('Нажимая “Да” введенные карточные данные не будут сохранены', '«Иә» түймесін басу арқылы енгізілген карта деректері сақталмайды');
}

String timeForPayExpired() {
  return getStrFromRes('Время оплаты истекло', 'Төлеу уақыты аяқталды');
}

String tryFormedNewCart() {
  return getStrFromRes('Попробуйте сформировать\nкорзину занова', 'Себетті қайтадан\nжасап көріңіз');
}

String weRepeatYourPayment() {
  return getStrFromRes('Повторяем ваш платеж', 'Төлеміңізді қайталаймыз');
}

String thisNeedSomeTime() {
  return getStrFromRes('Это займет немного времени', 'Бұл біраз уақытты алады');
}

String forChangeLimitInKaspi() {
  return getStrFromRes('Для изменения лимита \nв приложении Kaspi.kz:', 'Kaspi.kz қолданбасындағы \nшектеуді өзгерту үшін:');
}

String forChangeLimitInHomebank() {
  return getStrFromRes('Для изменения лимита \nв приложении Homebank:', 'Homebank қолданбасындағы \nшектеуді өзгерту үшін:');
}

String somethingWentWrong() {
  return getStrFromRes('Что-то пошло не так', 'Бірдеңе дұрыс болмады');
}

String somethingWentWrongDescription() {
  return getStrFromRes('Обратитесь в службу поддержки магазина', 'Дүкен қолдау қызметіне хабарласыңыз');
}

String orPayWithCard() {
  return getStrFromRes('или оплатите картой', 'немесе картамен төлеңіз');
}

String payAnotherCard() {
  return getStrFromRes(payAnotherCardRu, payAnotherCardKz);
}