import 'package:apay/ui/resources/colors_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/fonts.dart';

Widget initErrorInfoField(String? message, {double leftPadding = 16}) {
  return message != null ? Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
          padding: EdgeInsets.only(left: leftPadding, top: 6, right: 6),
          child: SvgPicture.asset('assets/images/alarm.svg')),
      Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            message,
            style: Fonts.caption400().copyWith(color: ColorsSdk.stateError),
          ))
    ],
  ) : const SizedBox(width: double.infinity);
}
