import 'package:apay/ui/themes/colors.dart';
import 'package:flutter/material.dart';

class ProgressDialogPrimary extends StatelessWidget {
  const ProgressDialogPrimary({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness == Brightness.light;
    return Scaffold(
      body: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorsSdk.mainBrand),
        ),
      ),
      backgroundColor: brightness ?  ColorsSdk.bgMain.withOpacity(
          0.70) :  ColorsSdk.bgAccent.withOpacity(
          0.70), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    );
  }
}