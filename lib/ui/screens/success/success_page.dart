import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/constants/routes.dart';
import '../../../data/constants/strings.dart';
import '../../../data/utils/exit_utils.dart';
import '../../../data/utils/logger.dart';
import '../../themes/colors.dart';
import '../../themes/fonts.dart';
import '../../ui_components/circular_progress_bar.dart';

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
                          'assets/images/pay_success.svg',
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
                          exitSdk();
                        },
                        child: Text(
                          goToMarker(),
                          style: Fonts.h2().copyWith(color: ColorsSdk.textInversion),
                        ))),
              ],
            ),
          ),
        ));
  }
}
