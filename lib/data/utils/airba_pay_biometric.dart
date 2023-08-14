import 'package:flutter/cupertino.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class AirbaPayBiometric {

  void authenticate({
    required BuildContext context,
    required void Function() onResult
  }) {
    Future<void> localAuth(BuildContext context) async {
      final localAuth = LocalAuthentication();
      final didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate');
      if (didAuthenticate) {
        Navigator.pop(context);
      }
    }

    screenLock(
      context: context,
      correctString: '1234',
      customizedButtonChild: Icon(Icons.fingerprint),
      customizedButtonTap: () async => await localAuth(context),
      onOpened: () async => await localAuth(context),
    );

/*    DataHolder.isAuthenticated = canAuthenticate;
    //todo ошибка с контекстом, хз, как решить
    // context.read<StartProcessingBloc>().add(const ChangedStartProcessingEvent(isAuthenticated: true));
    onResult();*/
  }
}