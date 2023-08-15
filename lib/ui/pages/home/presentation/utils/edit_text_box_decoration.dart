import 'package:flutter/cupertino.dart';

import '../../../../resources/colors_sdk.dart';

BoxDecoration initEditTextBoxDecoration(
    bool hasError,
    FocusNode focusNode
) {
  return BoxDecoration(
      color: hasError
          ? ColorsSdk.stateBgError
          : ColorsSdk.bgBlock,
      borderRadius: BorderRadius.circular(8.0),
      border: hasError
          ? Border.all(color: ColorsSdk.stateError)
          : focusNode.hasFocus
          ? Border.all(color: ColorsSdk.colorBrandMain)
          : Border.all(color: ColorsSdk.gray5));
}