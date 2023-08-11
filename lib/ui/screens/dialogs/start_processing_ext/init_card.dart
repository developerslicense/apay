import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/constants/strings.dart';
import '../../../../data/models/card.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import 'init_pay_with_new_card.dart';

Widget initViewStartProcessingCards({
  required List<BankCard> savedCards,
  required BankCard? selectedCard,
}) {

  int selected = 0;

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
              selected = 0;
              selectedCard = savedCards[0];
            }
        ),
      if(savedCards.length > 1)
        _initCard(
            card: savedCards[1],
            isSelected: selected == 1,
            isFirst: true,
            clickOnCard: () {
              selected = 1;
              selectedCard = savedCards[1];
            }
        ),
      if(savedCards.length > 2)
        _initCard(
            card: savedCards[2],
            isSelected: selected == 2,
            isFirst: true,
            clickOnCard: () {
              selected = 2;
              selectedCard = savedCards[2];
            }
        ),
      if(savedCards.length > 3)
        _initCard(
            card: savedCards[3],
            isSelected: selected == 3,
            isFirst: true,
            clickOnCard: () {
              selected = 3;
              selectedCard = savedCards[3];
            }
        ),

      const SizedBox(height: 32),
      initViewStartProcessingPayWithNewCard(
        actionClick: (){
          // actionClose()
          // val intent = Intent(context, AirbaPayActivity::class.java)
          // context.startActivity(intent)
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
          child: Row(children: [
              SvgPicture.asset('assets/images/visa.svg', height: 24.0), //todo
              const SizedBox(width: 16,),
              Text(card.getMaskedPanCleared()),
              /*Row(
                children: [

                ],
              ),*/

              if(isSelected) SvgPicture.asset('assets/images/ic_radio_button_on.svg', height: 24.0),
              if(!isSelected) SvgPicture.asset('assets/images/ic_radio_button_off.svg', height: 24.0)

          ])
        ),
        const SizedBox(height: 16,)
      ],
    )
  );

}
/*


Row(
modifier = Modifier
    .padding(horizontal = 16.dp)
    .fillMaxWidth(),
horizontalArrangement = Arrangement.SpaceBetween,
verticalAlignment = Alignment.CenterVertically
) {
Row(
verticalAlignment = Alignment.CenterVertically
) {
LoadImageSrc(imageSrc = card.typeIcon)

Spacer(modifier = Modifier.width(16.dp))

Text(
style = LocalFonts.current.semiBold,
text = card.getMaskedPanCleared()
)
}

LoadImageSrc(
imageSrc = if (isSelected) R.drawable.ic_radio_button_on else R.drawable.ic_radio_button_off,
)
}

}*/
