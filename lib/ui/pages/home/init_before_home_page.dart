import 'package:apay/airba_pay_sdk.dart';
import 'package:apay/ui/resources/colors_sdk.dart';
import 'package:flutter/material.dart';

import '../../resources/button_style.dart';

class InitBeforeHomePage extends StatefulWidget {
  const InitBeforeHomePage({super.key});

  @override
  State<InitBeforeHomePage> createState() => _InitBeforeHomePageState();
}

class _InitBeforeHomePageState extends State<InitBeforeHomePage> {
  var _isSdkInitialised = false;

  @override
  Widget build(BuildContext context) {
    if(!_isSdkInitialised) {
      _isSdkInitialised = true;
      _onCreate();
    }

    return Container(
        color: ColorsSdk.bgBlock,
        child: Column(
              children: [
                AppBar(title: const Text('Оплата заказа', style: TextStyle(fontSize: 16))),
                const SizedBox(height: 100,),
                const Text(
                  'Flutter sdk \n в дебаг сборке переход на следующий экран подвисает. '
                      'Это нормально из-за специфики флаттера. В релизе все норм. Жди 5-10 секунд',
                  style: TextStyle(fontSize: 24),
                ),
                TextButton(
                  onPressed: () {
                    _initProcessing();
                    airbaPaySdkProcessingBottomSheet(context: context);
                  },
                  style: buildButtonStyle(),
                  child: const Text('Перейти на эквайринг'),
                )
              ],
          )
      );
  }

  void _onCreate() {
     AirbaPaySdk.initOnCreate(
        isProd: false,
        phone: '77051234567',
        lang: AirbaPaySdkLang.ru,
        shopId: 'test-merchant',
        password: '123456',
        terminalId: '64216e7ccc4a48db060dd689',
        failureCallback: 'https://site.kz/failure-clb',
        successCallback: 'https://site.kz/success-clb',
        userEmail: 'test@test.com',
        // colorBrandMain: Color(0xFFF15515),
     );
  }

  void _initProcessing() {
    var someInvoiceId = DateTime.now().millisecondsSinceEpoch.toString();
    var someOrderNumber = DateTime.now().millisecondsSinceEpoch.toString();

    AirbaPaySdk.initProcessing(
        purchaseAmount: 51000,
        invoiceId: someInvoiceId,
        orderNumber: someOrderNumber,
        goods: [
          Goods(
              model: 'Чай Tess Banana Split черный 20 пирамидок',
              quantity: 1,
              brand: 'Tess',
              price: 1000,
              category: 'Black tea')
        ],
        settlementPayments: []
    );
  }
}
