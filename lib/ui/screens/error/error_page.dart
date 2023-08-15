import 'package:apay/data/constants/errors_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/button_style.dart';
import '../../themes/fonts.dart';
import '../dialogs/dialog_exit.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  _ErrorPageState();

  @override
  Widget build(BuildContext context) {
    double iconPaddingTop = MediaQuery.of(context).size.height * 0.2;
    double iconSize = MediaQuery.of(context).size.width * 0.6;

    final Map<String, String?>? args = ModalRoute.of(context)?.settings.arguments as Map<String, String?>?;
    final ErrorsCode error = ErrorsCode.initByCode(int.parse(args?['errorCode'] ?? '1'));

    return WillPopScope(
        onWillPop: () {
          showDialog<void>(
            context: context,
            builder: (_) => initDialogExit(context),
          );
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
                          image: const AssetImage('assets/images/pay_failed.png'),
                          height: iconSize,
                          width: iconSize,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          error.message(),
                          style: Fonts.h3(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.description(),
                          style: Fonts.bodyRegular(),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                _init2Button(error, context),
              ],
            ),
          ),
        ));
  }

  Positioned _init2Button(ErrorsCode error, BuildContext context) {
    return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            error.clickOnTop(context);
                          },
                          style: buildButtonStyle(),
                          child: Text(
                            error.buttonTop(),
                            style: buildButtonTextStyle(),
                          )),
                        const SizedBox(height: 16,),
                        TextButton(
                          onPressed: () {
                            error.clickOnBottom(context);
                          },
                          style: buildButtonStyle(isMainBrand: false),
                          child: Text(
                            error.buttonBottom(),
                            style: buildButtonTextStyle(isMainBrand: false),
                          )),
                      ]
                  )
              );
  }
}
