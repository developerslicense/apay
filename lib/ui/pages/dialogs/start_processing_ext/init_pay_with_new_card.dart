import 'package:apay/ui/resources/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/constants/strings.dart';
import '../../../resources/colors_sdk.dart';

Widget initViewStartProcessingPayWithNewCard(
    {required void Function() actionClick}) {
  return GestureDetector(
          onTap: (){
            actionClick();
      },
      child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsSdk.gray10),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/ic_add.svg', height: 8.0),
                      const SizedBox(width: 12),
                      Text(payAnotherCard(), style: Fonts.semiBold().copyWith(color: ColorsSdk.textBlue))
                    ])
              ]))));

}
