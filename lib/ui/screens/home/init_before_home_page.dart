import 'package:apay/airba_pay_sdk.dart';
import 'package:apay/data/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InitBeforeHomePage extends StatefulWidget {
  const InitBeforeHomePage({super.key});

  @override
  State<InitBeforeHomePage> createState() => _InitBeforeHomePageState();
}

class _InitBeforeHomePageState extends State<InitBeforeHomePage> {
  static const platform = MethodChannel('airba_pay_channel');

  @override
  Widget build(BuildContext context) {
    platform.setMethodCallHandler((call) async {
      var arguments = call.arguments.toString();
      print("init state setMethodCallHandler $arguments");
      AirbaPaySdk.initOnStart(arguments);

      if (mounted) {
        Navigator.pushNamed(
          context,
          routesHome,
        );
      }
    });

    return const SizedBox();
  }
}
