import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../data_holder.dart';

class AirbaPayBiometric {

  Future<void> authenticate({
    required BuildContext context,
    required void Function() onResult
  }) async {

    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if(canAuthenticate) {
      Future<void> localAuth() async {
        final localAuth = LocalAuthentication();
        final didAuthenticate = await localAuth.authenticate(
            localizedReason: requestAccessToSavedCards()
        );
        DataHolder.isAuthenticated = didAuthenticate;
        onResult();
      }

      await localAuth();

    } else {
      DataHolder.isAuthenticated = false;
      onResult();
    }
  }
}
