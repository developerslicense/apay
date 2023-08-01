import 'package:apay/data/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../themes/colors.dart';
import '../../../../themes/fonts.dart';
import 'clear_icon.dart';

InputDecoration inputTextFieldDecoration({
    String? text,
    String? iconPaymentSystem,
    bool isFocused = false,
    bool isError = false,
    bool needSuffixExtended = false,
    InkWell? prefix,
    TextEditingController? controller,
    Function()? afterClearText}) {
    return InputDecoration(
      labelText: text,
      counterText: "",
      floatingLabelStyle: Fonts
          .regular()
          .copyWith(color: isError ? ColorsSdk.stateError : ColorsSdk.colorBrandMain),
      labelStyle: Fonts
          .regular()
          .copyWith(color: isError ? ColorsSdk.stateError : ColorsSdk.textLight),
      contentPadding: const EdgeInsets.only(top: 1),
      prefixIcon: prefix,
      suffixIcon: SizedBox(
          width: needSuffixExtended ? 100.0 : 30.0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isBlank(iconPaymentSystem))
                  _initPaymentsSystemIcon(iconPaymentSystem ?? ''),
                if (isFocused && afterClearText != null)
                  initClearIcon(controller!, afterClearText)
              ])),

    );
}

Padding _initPaymentsSystemIcon(String paySystemIcon) {
  Widget asset = SvgPicture.asset(paySystemIcon);

  if (paySystemIcon.contains('union-pay.svg')
      || paySystemIcon.contains('maestro-card.svg')) {
    asset = SvgPicture.asset(paySystemIcon, height: 16, width: 16);
  }

  if (paySystemIcon.contains('mir.svg')) {
    asset = SvgPicture.asset(paySystemIcon, height: 10, width: 10);
  }

  return Padding(
      padding: const EdgeInsets.only(top: 7, bottom: 7, right: 10),
      child: asset
  );
}