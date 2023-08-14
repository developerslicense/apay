import 'package:apay/data/utils/navigate_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/constants/strings.dart';
import '../../../../data/models/card.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import 'init_pay_with_new_card.dart';

Widget initViewStartProcessingCards({
  required BuildContext context,
  required List<BankCard> savedCards,
  required int selected,
  required void Function(int) actionClickCard,
}) {

  return Column(
    children: [
      const SizedBox(height: 32),
      Text(orPayWithCard(), style: Fonts.regular()),
      const SizedBox(height: 16),
      if(savedCards.isNotEmpty)//todo это костыль вместо ListView т.к. проблемы есть с рендерингом
        _initCard(
            card: savedCards[0],
            isSelected: selected == 0,
            isFirst: true,
            clickOnCard: () {
              actionClickCard(0);
            }
        ),
      if(savedCards.length > 1)
        _initCard(
            card: savedCards[1],
            isSelected: selected == 1,
            isFirst: false,
            clickOnCard: () {
              actionClickCard(1);
            }
        ),
      if(savedCards.length > 2)
        _initCard(
            card: savedCards[2],
            isSelected: selected == 2,
            isFirst: false,
            clickOnCard: () {
              actionClickCard(2);
            }
        ),
      if(savedCards.length > 3)
        _initCard(
            card: savedCards[3],
            isSelected: selected == 3,
            isFirst: false,
            clickOnCard: () {
              actionClickCard(3);
            }
        ),
      if(savedCards.length > 4)
        _initCard(
            card: savedCards[4],
            isSelected: selected == 4,
            isFirst: false,
            clickOnCard: () {
              actionClickCard(4);
            }
        ),

      const SizedBox(height: 32),
      initViewStartProcessingPayWithNewCard(
        actionClick: (){
          openHome(context);
        }
      )
    ],
  );
}

Widget _initCard({
  required BankCard card,
  required bool isSelected,
  required bool isFirst,
  required void Function() clickOnCard
}) {
  return TextButton(
      onPressed: clickOnCard,
      child: Column(
      children: [
        if (!isFirst) const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(
            height: 1,
            color: ColorsSdk.gray5,
          ),
        ),
        const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(card.getTypeIcon(), height: 24.0),
                    const SizedBox(width: 16,),
                    Text(card.getMaskedPanCleared()),
                  ],
                ),

                if(isSelected) SvgPicture.asset('assets/images/ic_radio_button_on.svg', height: 24.0),
                if(!isSelected) SvgPicture.asset('assets/images/ic_radio_button_off.svg', height: 24.0)

          ])
        ),
        const SizedBox(height: 16,)
      ],
    )
  );

}
