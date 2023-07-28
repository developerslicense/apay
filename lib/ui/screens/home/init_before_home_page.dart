import 'package:apay/airba_pay_sdk.dart';
import 'package:flutter/material.dart';

import '../../../data/models/payments_request.dart';

class InitBeforeHomePage extends StatefulWidget {
  const InitBeforeHomePage({super.key});

  @override
  State<InitBeforeHomePage> createState() => _InitBeforeHomePageState();
}

class _InitBeforeHomePageState extends State<InitBeforeHomePage> {
  @override
  Widget build(BuildContext context) {
    var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    return Column(

      children: [
        const SizedBox(height: 100,),
        const Text(
            'Flutter sdk \n в дебаг сборке переход на следующий экран подвисает. '
                'Это нормально из-за специфики флаттера. В релизе все норм. Жди 5-10 секунд',
          style: TextStyle(fontSize: 24),
        ),
        TextButton(
          onPressed: () {
            _start(context, timeStamp);
          },
          child: const Text('Перейти на эквайринг'),
        )
      ],
    );
  }

  void _start(BuildContext context, String timeStamp) {
     AirbaPaySdk.startProcessing(
        context: context,
        isProd: false,
        purchaseAmount: 10500,
        phone: '77051234567',
        lang: AirbaPaySdkLang.ru,
        orderNumber: timeStamp,
        invoiceId: timeStamp,
        shopId: 'test-merchant',
        password: '123456',
        terminalId: '64216e7ccc4a48db060dd689',
        failureBackUrl: 'https://site.kz/failure',
        failureCallback: 'https://site.kz/failure-clb',
        successBackUrl: 'https://site.kz/success',
        successCallback: 'https://site.kz/success-clb',
        goods: [
          Goods(
              model: 'Чай Tess Banana Split черный 20 пирамидок',
              quantity: 1,
              brand: 'Tess',
              price: 1000,
              category: 'Black tea')
        ],
        userEmail: 'test@test.com',
        connectTimeout: 60,
        receiveTimeout: 60,
        sendTimeout: 60);
  }
}
