import 'package:flutter/cupertino.dart';

import '../../../../themes/colors.dart';

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
          ? Border.all(color: ColorsSdk.mainBrand)
          : Border.all(color: ColorsSdk.gray5));
}