import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

ButtonStyle buildButtonStyle({bool isMainBrand = true}) {
  return TextButton.styleFrom(
      backgroundColor: isMainBrand ? ColorsSdk.colorBrandMain : ColorsSdk.gray5,
      minimumSize: const Size.fromHeight(48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ));
}

TextStyle buildButtonTextStyle({bool isMainBrand = true}) {
  return Fonts.h2().copyWith(color: isMainBrand ? ColorsSdk.colorBrandInversion : ColorsSdk.colorBrandMain);
}
