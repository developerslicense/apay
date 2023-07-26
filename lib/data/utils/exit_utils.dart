import 'package:flutter/services.dart';

void exitSdk() {
  // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  SystemNavigator.pop();
}