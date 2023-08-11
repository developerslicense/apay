import 'package:flutter/cupertino.dart';
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
      ListView.builder(
          itemCount: savedCards.length,
          itemBuilder: (context, index) {
            var card = savedCards[index];
            return _initCard(
              card: card,
              isSelected: selected == index,
              isFirst: index == 0,
              clickOnCard: () {
                  selected = index;
                  selectedCard = card;
                }
            );
          }),
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
