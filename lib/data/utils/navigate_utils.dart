import 'dart:ffi';

import 'package:apay/data/constants/routes.dart';
import 'package:flutter/cupertino.dart';

import '../../main.dart';
import '../constants/errors_code.dart';
import '../data_holder.dart';
import 'string_utils.dart';

void openHome(BuildContext context) {
  Navigator.pushNamed(
    context,
    routesHome,
  );
}

void backHome(BuildContext context) {
  openHome(context);
}

void openWebView(String? action, String isRetry, BuildContext context) {
  Navigator.pushNamed(
      context,
      routesWebView,
      arguments: {
        'action': action,
        'is_retry': isRetry
      }
  );
}

void openRepeat(BuildContext context) {
  Navigator.pushNamed(context, routesRepeat);
}

void openErrorPageWithCondition(
    int? errorCode,
    BuildContext context,
    bool isRetry
) {
  final ErrorsCode error = ErrorsCode.initByCode(errorCode ?? 1);

  if (error == ErrorsCode.error_1) {
    Navigator.pushNamed(
        context,
        routesErrorSomethingWrong
    );

  } else if (error.code == ErrorsCode.error_5020.code || errorCode == null) {
    Navigator.pushNamed(
      context,
      routesErrorFinal,
    );

  } else if (error.code == ErrorsCode.error_5999.code && !isBlank(DataHolder.bankName ?? "")) {
    Navigator.pushNamed(
      context,
      routesErrorWithInstruction
    );

  } else {
    Navigator.pushNamed(
        context,
        routesError,
        arguments: {
          'errorCode': error.code.toString(),
          'is_retry': isRetry.toString()
        }
    );
  }
}

void openSuccess(BuildContext context) {
  Navigator.pushNamed(
      context,
      routesSuccess
  );
}
