import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/colors_sdk.dart';
import '../resources/fonts.dart';

Widget initHeader({
  required String title,
  required Function() actionClose
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
          padding: const EdgeInsets.only(top: 11, bottom: 16),
          child: SvgPicture.asset('assets/images/line_gray.svg')
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, bottom: 6, right: 40),
          ),
          Text(
            title,
            style: Fonts.subtitleBold(),
          ),
          InkWell(
              onTap: () {
                actionClose();
              },
              child: Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 6, right: 16),
                  child: SvgPicture.asset('assets/images/cancel.svg')
              ))
        ],
      ),
      const Divider(
        height: 1,
        color: ColorsSdk.gray10,
      )
    ],
  );
}