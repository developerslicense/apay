import 'package:apay/ui/screens/error/error_final_page.dart';
import 'package:apay/ui/screens/error/error_page.dart';
import 'package:apay/ui/screens/error/error_something_wrong_page.dart';
import 'package:apay/ui/screens/error/error_with_instruction_page.dart';
import 'package:apay/ui/screens/error/repeat_page.dart';
import 'package:apay/ui/screens/home/home_page.dart';
import 'package:apay/ui/screens/home/init_before_home_page.dart';
import 'package:apay/ui/screens/success/success_page.dart';
import 'package:apay/ui/screens/webview/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/constants/routes.dart';

/// Ссылка на документацию разработчика sdk ->
/// Ссылка на документацию для внедрения в мобильные приложения ->
/// Ссылка на документацию бэка -> https://docs.google.com/document/d/1KgU-MDTC2kUfezvmWWzeRIgPvwc9SIJT/edit
/// Swagger -> https://sps.airbapay.kz/acquiring-api/sdk/swagger/index.html#/

/// Ссылка на гит sdk -> https://gitlab-pcidss.airbapay.kz/airbapay/payment-system/mobile/sdk
/// Ссылка на гит sdk Android ->
/// Ссылка на гит sdk iOS ->

/// Когда нужно проверить либу во время разработки, то true.
/// Без этого не произойдут нужные инициализации
var _isDebugForSdkDeveloper = false;

void main() async {

  if (_isDebugForSdkDeveloper) {
    runApp(const TestSdkApp());

  } else {
    runApp(const SdkApp());
  }
}

class SdkApp extends StatelessWidget {
  const SdkApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        routesHome: (context) => const HomePage(title: 'AirbaPay'),
        routesWebView: (context) => const WebViewPage(),
        routesRepeat: (context) => const RepeatPage(),
        routesSuccess: (context) => const SuccessPage(),
        routesError: (context) => const ErrorPage(),
        routesErrorSomethingWrong: (context) => const ErrorSomethingWrongPage(),
        routesErrorFinal: (context) => const ErrorFinalPage(),
        routesErrorWithInstruction: (context) => const ErrorWithInstructionPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none
        ),
      ),
      home: const HomePage(title: 'Airba Pay'));
  }
}

class TestSdkApp extends StatelessWidget {
  const TestSdkApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        routesHome: (context) => const HomePage(title: 'AirbaPay'),
        routesWebView: (context) => const WebViewPage(),
        routesRepeat: (context) => const RepeatPage(),
        routesSuccess: (context) => const SuccessPage(),
        routesError: (context) => const ErrorPage(),
        routesErrorSomethingWrong: (context) => const ErrorSomethingWrongPage(),
        routesErrorFinal: (context) => const ErrorFinalPage(),
        routesErrorWithInstruction: (context) => const ErrorWithInstructionPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none
        )
      ),
      home: const InitBeforeHomePage());
  }
}
