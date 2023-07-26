import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/constants/routes.dart';
import '../../../data/constants/strings.dart';
import '../../../data/data_holder.dart';
import '../../../data/models/payments_response.dart';
import '../../../data/network/repository/payments_repository.dart';
import '../../themes/colors.dart';
import '../../themes/fonts.dart';
import '../dialogs/dialog_exit.dart';
import 'error_util.dart';

class RepeatPage extends StatefulWidget {
  const RepeatPage({super.key});

  @override
  createState() => _RepeatPageState();
}

class _RepeatPageState extends State<RepeatPage> {
  _RepeatPageState();

  bool _requested = false;

  @override
  Widget build(BuildContext context) {
    double progressBarSize = MediaQuery.of(context).size.width * 0.3;

    if (!_requested) {
      _requested = true;
      _onStart();
    }

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
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: Stack(
              children: <Widget>[
                Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weRepeatYourPayment(),
                          style: Fonts.h3(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          thisNeedSomeTime(),
                          style: Fonts.bodyRegular(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24,),
                        SizedBox(
                          height: progressBarSize,
                          width: progressBarSize,
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(ColorsSdk.mainBrand),
                          ),
                        )
                      ],
                    ),
              ],
            ),
          ),
        ));
  }

  void _onStart() async {
    PaymentEntryResponse? response = await paymentAccountEntryRetry(accessToken: DataHolder.accessToken);

    if (mounted) {
      if (response?.isSecure3D() == true) {
        Navigator.pushNamed(
            context,
            routesWebView,
            arguments: {
              'action': response?.secure3D()?.action,
              'is_retry': 'true'
            }
        );

      } else if(response?.errorCode() != 0 || response == null) {
        openErrorPageWithCondition(
            response?.errorCode(),
            context,
            '',
            true
        );

      } else {
        Navigator.pushNamed(
            context,
            routesSuccess
        );

      }
    }
  }
}
