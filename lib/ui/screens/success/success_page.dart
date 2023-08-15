import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constants/strings.dart';
import '../../../data/utils/exit_utils.dart';
import '../../themes/button_style.dart';
import '../../themes/fonts.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  _SuccessPageState();

  @override
  Widget build(BuildContext context) {
    double iconPaddingTop = MediaQuery.of(context).size.height * 0.3;
    double iconSize = MediaQuery.of(context).size.width * 0.6;

    return WillPopScope(
        onWillPop: () {
          exitSdk(context);
          return Future.value(false);
        },
        child: Scaffold(
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
                          image: const AssetImage('assets/images/pay_success.png'),
                          height: iconSize,
                          width: iconSize,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          paySuccess(),
                          style: Fonts.h3(),
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
          ),
        ));
  }
}
