import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/fonts.dart';

Row initBankInfo() {
  return Row(//todo нужна логика для показа и скрытия
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
          padding: const EdgeInsets.only(left: 16, top: 6, right: 6),
          child: SvgPicture.asset('assets/images/master_card.svg')), //todo icons
      Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            'Евразийский банк', //todo name
            style: Fonts.caption400(),
          ))
    ],
  );
}