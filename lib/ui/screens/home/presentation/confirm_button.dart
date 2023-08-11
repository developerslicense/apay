import 'package:apay/data/utils/string_utils.dart';
import 'package:apay/ui/screens/home/bloc/home_event.dart';
import 'package:apay/ui/screens/home/presentation/utils/read_state.dart';
import 'package:flutter/material.dart';

import '../../../../data/constants/errors_code.dart';
import '../../../../data/constants/regex.dart';
import '../../../../data/constants/routes.dart';
import '../../../../data/constants/strings.dart';
import '../../../../data/data_holder.dart';
import '../../../../data/models/auth.dart';
import '../../../../data/models/card.dart';
import '../../../../data/models/payments_response.dart';
import '../../../../data/network/repository/auth_repository.dart';
import '../../../../data/network/repository/payments_repository.dart';
import '../../../../data/utils/card_utils/card_date_utils.dart';
import '../../../../data/utils/card_utils/card_utils.dart';
import '../../../../data/utils/number_clearer_utils.dart';
import '../../../themes/button_style.dart';
import '../../../../data/utils/navigate_utils.dart';

Positioned initConfirmButton(BuildContext context) {
  return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 27, 16, 24),
          child: TextButton(
              onPressed: () {
                _onPressed(context);
              },
              style: buildButtonStyle(),
              child: Text(
                '${payAmount()} ${DataHolder.purchaseAmount}',
                style: buildButtonTextStyle(),
              ))));
}

void _onPressed(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();

  bool hasError = false;

  if (readState(context).emailState?.switched == true
      && isBlank(readState(context).email)) {
    hasError = true;
    addState(context, EmailEvent(switched: true, errorEmail: wrongEmail()));

  } else if (readState(context).emailState?.switched == true &&
    readState(context).email?.contains(RegExp(Regex.emailValidation)) == false) {
    hasError = true;
    addState(context, EmailEvent(switched: true, errorEmail: wrongEmail()));

  } else {
    addState(context, EmailEvent(switched: readState(context).emailState?.switched ?? false, errorEmail: null));
  }

  if (isBlank(readState(context).cardNumber)) {
    hasError = true;
    addState(context, CardNumberEvent(errorCardNumber: needFillTheField()));

  } else if (!validateCardNumWithLuhnAlgorithm(readState(context).cardNumber)) {
    hasError = true;
    addState(context, CardNumberEvent(errorCardNumber: wrongCardNumber()));

  } else {
    addState(context, const CardNumberEvent(errorCardNumber: null));
  }

  if (isBlank(readState(context).cvv)) {
    //todo проверку на валидность c бэка?
    hasError = true;
    addState(context, CvvEvent(errorCvv: needFillTheField()));

  } else if ((readState(context).cvv?.length ?? 0) < 3) {
    hasError = true;
    addState(context, CvvEvent(errorCvv: wrongCvv()));

  } else {
    addState(context, const CvvEvent(errorCvv: null));
  }

  if (isBlank(readState(context).dateExpired)) {
    hasError = true;
    addState(context, DateExpiredEvent(errorDateExpired: needFillTheField()));

  } else if (!isDateValid(readState(context).dateExpired)) {
    hasError = true;
    addState(context, DateExpiredEvent(errorDateExpired: wrongDate()));

  } else {
    addState(context, const DateExpiredEvent(errorDateExpired: null));
  }

  if (!hasError) {
    addState(context, const PaymentProcessingEvent(isPaymentProcessing: true));

    BankCard card = BankCard(
      pan: getNumberCleared(readState(context).cardNumber),
      expire: readState(context).dateExpired,
      name: "Name Holder"
    );

    DataHolder.userEmail = readState(context).email;

    _startProcessing(
        readState(context).saveCardData,
        readState(context).emailState?.switched ?? false,
        card,
        readState(context).cvv,
        (Secure3D? secure3d) {
          addState(context, const PaymentProcessingEvent(isPaymentProcessing: false));
          openWebView(secure3d?.action, context);
        },
        () {
          addState(context, const PaymentProcessingEvent(isPaymentProcessing: false));
          openSuccess(context);
        },
        (int errorCode) {
          addState(context, const PaymentProcessingEvent(isPaymentProcessing: false));
          openErrorPageWithCondition(errorCode, context);
        },
    );

  }
}

void _startProcessing(
    bool saveCard,
    bool sendReceipt,
    BankCard card,
    String? cvv,
    void Function(Secure3D? secure3d) on3DS,
    void Function() onSuccess,
    void Function(int errorCode) onError,
) async {

  try {
    AuthResponse? authResponseBeforeCreate = await auth(
        paymentId: null,
        user: DataHolder.shopId,
        password: DataHolder.password,
        terminalId: DataHolder.terminalId,
        accessToken: null);
    String? accessToken = authResponseBeforeCreate?.getAccessToken();

    PaymentCreateResponse? result = await createPayment(
      saveCard: saveCard,
    );

    await auth(
        paymentId: result?.id(),
        user: DataHolder.shopId,
        password: DataHolder.password,
        terminalId: DataHolder.terminalId,
        accessToken: DataHolder.accessToken);

    PaymentEntryResponse? entryResponse = await paymentAccountEntry(
      saveCard: saveCard,
      sendReceipt: sendReceipt,
      card: card,
      cvv: cvv,
    );

    if (entryResponse == null || entryResponse.errorCode() != 0) {
      onError(entryResponse?.errorCode() ?? ErrorsCode.error_1.code);

    } else if (entryResponse.isSecure3D() == true) {
      on3DS(entryResponse.secure3D());

    } else {
      onSuccess();
    }
  } catch (e) {
    onError(ErrorsCode.error_1.code);
  }

}
//       //todo логика насчет сохранненой карты выше смотри