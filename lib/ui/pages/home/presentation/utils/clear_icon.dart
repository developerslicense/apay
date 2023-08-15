import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

InkWell initClearIcon(TextEditingController controller, Function() afterClearText) {
  return InkWell(
      onTap: () {
        controller.clear();
        afterClearText();
      },
      child: Padding(
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          child: SvgPicture.asset('assets/images/ic_close.svg')));
}