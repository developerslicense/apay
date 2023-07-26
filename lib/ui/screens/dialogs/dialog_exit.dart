import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constants/strings.dart';
import '../../../data/utils/exit_utils.dart';
import '../../themes/colors.dart';
import '../../themes/fonts.dart';

Widget initDialogExit(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          SvgPicture.asset(
              'assets/images/warning_red_oval.svg',
              height: 56.0,
              width: 56.0),
          const SizedBox(height: 16),
          Text(dropPayment(), style: Fonts.subtitleBold()),
          const SizedBox(height: 24),
          Text(dropPaymentDescription(), style: Fonts.bodyRegular(), textAlign: TextAlign.center,),
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: Text(
                    no(),
                    style: Fonts.h2().copyWith(color: ColorsSdk.textInversion),
                  ))),
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: TextButton(
                  onPressed: () {
                    exitSdk();
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5);
                            }
                            return ColorsSdk.gray5;
                          })),
                  child: Text(
                    yes(),
                    style: Fonts.h2().copyWith(color: ColorsSdk.mainBrand),
                  ))),
        ],
      ),
  );
}
