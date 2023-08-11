import 'package:apay/ui/themes/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/constants/strings.dart';
import '../../../themes/colors.dart';

Widget initViewStartProcessingPayWithNewCard(
    {required void Function() actionClick}) {
  return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: ColorsSdk.bgMain,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset('assets/images/ic_add.svg', height: 24.0),
                  const SizedBox(width: 12),
                  Text(payAnotherCard(), style: Fonts.semiBold().copyWith(color: ColorsSdk.textBlue))
                ])
          ])));
/*   Card(
        shape = RoundedCornerShape(8.dp),
        elevation = 0.dp,
        border = BorderStroke(
            width = 0.1.dp,
            color = ColorsSdk.gray10
        ),
        modifier = Modifier
            .padding(horizontal = 16.dp)
            .fillMaxWidth()
            .height(32.dp)
            .clickable(
                role = Role.Button,
                enabled = true,
                onClick = { actionClick() }
            )

    ) {
        ConstraintLayout(
            modifier = Modifier.fillMaxWidth(),
        ) {
            val (plusRef, titleRef) = createRefs()

            Image(
                painter = painterResource(R.drawable.ic_add),
                contentDescription = "ic_add",
                modifier = Modifier
                    .size(16.dp)
                    .constrainAs(plusRef) {
                        top.linkTo(parent.top)
                        bottom.linkTo(parent.bottom)
                        end.linkTo(titleRef.start, margin = 12.dp)
                    },
                colorFilter = ColorFilter.tint(color = ColorsSdk.textBlue)
            )

            Text(
                text = payAnotherCard(),
                color = ColorsSdk.textBlue,
                style = LocalFonts.current.semiBold,
                modifier = Modifier
                    .constrainAs(titleRef) {
                        top.linkTo(parent.top)
                        bottom.linkTo(parent.bottom)
                        start.linkTo(parent.start)
                        end.linkTo(parent.end)
                    }
            )

        }
    }

    Spacer(modifier = Modifier.height(16.dp))
*/
}
