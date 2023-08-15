import 'package:flutter/cupertino.dart';

import '../../../../data/constants/strings.dart';
import '../../../resources/colors_sdk.dart';
import '../../../resources/fonts.dart';

Widget initViewStartProcessingAmount(String? purchaseAmount) {
  return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Container(
          decoration: BoxDecoration(
            color: ColorsSdk.bgMain,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(amountOfPurchase(),
                      style: Fonts.regular(),
                      textAlign: TextAlign.start),
                  Text(purchaseAmount ?? "",
                      style: Fonts.semiBold(),
                      textAlign: TextAlign.end),
                ],
              ))));
}