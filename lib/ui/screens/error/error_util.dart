import 'package:apay/data/constants/routes.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/constants/errors_code.dart';
import '../../../data/utils/string_utils.dart';

void openErrorPageWithCondition(
    int? errorCode,
    BuildContext context,
    String? bankName,
    bool isRetry
) {
  final ErrorsCode error = ErrorsCode.initByCode(errorCode ?? 1);

  if (error == ErrorsCode.error_1) {
    Navigator.pushNamed(
        context,
        routesErrorSomethingWrong,
        arguments: bankName
    );

  } else if (errorCode == ErrorsCode.error_5020.code || errorCode == null) {
    Navigator.pushNamed(
      context,
      routesErrorFinal,
    );

  } else if (errorCode == ErrorsCode.error_5999.code && !isBlank(bankName)) {
    Navigator.pushNamed(
      context,
      routesErrorWithInstruction,
      arguments: bankName
    );

  } else {
    Navigator.pushNamed(
        context,
        routesError,
        arguments: {
          'errorCode': errorCode.toString(),
          'is_retry': isRetry.toString()
        }
    );
  }
}
