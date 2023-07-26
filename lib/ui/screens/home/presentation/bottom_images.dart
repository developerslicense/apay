import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class HomeBottomImages extends StatelessWidget {
  const HomeBottomImages({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'assets/images/MasterCard.svg',
                  height: 32.0
              ),
              const SizedBox(width: 16.0),
              SvgPicture.asset(
                  'assets/images/Visa.svg',
                  height: 32.0
              ),
              const SizedBox(width: 16.0),
              SvgPicture.asset(
                  'assets/images/AmericanExpress.svg',
                  height: 32.0
              ),
            ],
          ),
          const SizedBox(height: 150.0),
        ]);
  }
}
