import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constants/strings.dart';
import '../../../data/utils/exit_utils.dart';
import '../../themes/button_style.dart';
import '../../themes/fonts.dart';

class ErrorSomethingWrongPage extends StatefulWidget {
  const ErrorSomethingWrongPage({super.key});

  @override
  createState() => _ErrorSomethingWrongPageState();
}

class _ErrorSomethingWrongPageState extends State<ErrorSomethingWrongPage> {
  _ErrorSomethingWrongPageState();

  @override
  Widget build(BuildContext context) {
    double iconPaddingTop = MediaQuery.of(context).size.height * 0.2;
    double iconSize = MediaQuery.of(context).size.width * 0.6;

    return WillPopScope(
        onWillPop: () {
          exitSdk();
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
                        SvgPicture.asset(
                          'assets/images/something_wrong.svg',
                          height: iconSize,
                          width: iconSize,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          somethingWentWrong(),
                          style: Fonts.h3(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          somethingWentWrongDescription(),
                          style: Fonts.bodyRegular(),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                _initButton(context),
              ],
            ),
          ),
        ));
  }

  Positioned _initButton(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    exitSdk();
                  },
                  style: buildButtonStyle(),
                  child: Text(
                    goToMarker(),
                    style: buildButtonTextStyle(),
                  )),
            ]
        )
    );
  }
}
