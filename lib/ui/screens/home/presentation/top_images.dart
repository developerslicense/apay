import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class HomeTopImages extends StatelessWidget {
  const HomeTopImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'assets/images/airba_pay.svg',
                  height: 32.0
              ),
              const SizedBox(width: 36.0),
              SvgPicture.asset(
                  'assets/images/sportmasters.svg',
                  height: 32.0
              ),
            ],
          )
        ]);
  }
}
