import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constants/strings.dart';
import '../../../data/utils/exit_utils.dart';
import '../../resources/button_style.dart';
import '../../resources/fonts.dart';

class ErrorFinalPage extends StatefulWidget {
  const ErrorFinalPage({super.key});

  @override
  createState() => _ErrorFinalPageState();
}

class _ErrorFinalPageState extends State<ErrorFinalPage> {
  _ErrorFinalPageState();

  @override
  Widget build(BuildContext context) {
    double iconPaddingTop = MediaQuery.of(context).size.height * 0.3;
    double iconSize = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: iconPaddingTop,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Image(
                          image: const AssetImage('assets/images/pay_failed.png'),
                          height: iconSize,
                          width: iconSize,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          timeForPayExpired(),
                          style: Fonts.h3(),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tryFormedNewCart(),
                          style: Fonts.bodyRegular(),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: TextButton(
                        onPressed: () {
                          exitSdk(context);
                        },
                        style: buildButtonStyle(),
                        child: Text(
                          goToMarker(),
                          style: buildButtonTextStyle(),
                        ))),
              ],
            ),
        ));
  }
}
