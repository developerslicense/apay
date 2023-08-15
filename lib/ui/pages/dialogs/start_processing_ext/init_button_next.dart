import 'package:apay/ui/resources/button_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/constants/strings.dart';
import '../../../../data/models/card.dart';
import '../../../../data/utils/navigate_utils.dart';
import '../../../resources/fonts.dart';

Widget initViewStartProcessingButtonNext({
  required BuildContext context,
  required List<BankCard> savedCards,
  required String? purchaseAmount,
  required bool isAuthenticated,
  required BankCard? selectedCard}) {

  return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 32),
      child: TextButton(
        style: buildButtonStyle(),
          onPressed: () {
            // Navigator.of(context).pop()}

            if (savedCards.isNotEmpty
                && isAuthenticated
            ) {
              /* val intent = Intent(context, AirbaPayActivity::class.java)
                intent.putExtra(ARG_CARD_ID, selectedCard.value?.id)
                intent.putExtra(ARG_CARD_PAN, selectedCard.value?.maskedPan)
                intent.putExtra(ARG_CARD_EXPIRE, selectedCard.value?.expiredForResponse)
                context.startActivity(intent)*/
              openHome(context);

            } else {
              openHome(context);
              /*val intent = Intent(context, AirbaPayActivity::class.java)
                context.startActivity(intent)*/
            }
          },
          child: savedCards.isNotEmpty && isAuthenticated ?
            Text('${payAmount()} $purchaseAmount', style: buildButtonTextStyle()) :
            Text(paymentByCard2(), style: buildButtonTextStyle())
      )
  );
}
