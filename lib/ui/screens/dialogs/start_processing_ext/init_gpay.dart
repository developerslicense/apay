import 'package:apay/ui/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget initViewStartProcessingGPay() {
  return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF000000),
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
          onPressed: () {},
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child:
                  SvgPicture.asset('assets/images/g_pay.svg', height: 24.0)))
  );