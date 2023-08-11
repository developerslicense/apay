import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget initViewStartProcessingGPay() {
  return Column(
    children: [
      const SizedBox(height: 16),
      TextButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SvgPicture.asset('assets/images/g_pay.svg', height: 24.0))
      )
    ],
  );
/*Spacer(modifier = Modifier.height(16.dp))

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier
            .padding(horizontal = 16.dp)
            .fillMaxWidth()
            .background(
                color = ColorsSdk.bgGPAY,
                shape = RoundedCornerShape(
                    topStart = 8.dp,
                    topEnd = 8.dp,
                    bottomEnd = 8.dp,
                    bottomStart = 8.dp
                )
            )
            .padding(16.dp)
    ) {
        LoadImageSrc(imageSrc = R.drawable.g_pay)
    }*/
}
