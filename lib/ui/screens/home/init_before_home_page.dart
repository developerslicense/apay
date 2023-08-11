import 'package:apay/airba_pay_sdk.dart';
import 'package:apay/ui/themes/colors.dart';
import 'package:flutter/material.dart';

import '../../themes/button_style.dart';

class InitBeforeHomePage extends StatefulWidget {
  const InitBeforeHomePage({super.key});

  @override
  State<InitBeforeHomePage> createState() => _InitBeforeHomePageState();
}

class _InitBeforeHomePageState extends State<InitBeforeHomePage> {
  final _isBottomSheet = true;
  var _isSdkInitialised = false;
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    if(!_isSdkInitialised) {
      _isSdkInitialised = true;
      _onCreate();
    }

    if (_isBottomSheet) {
      return  Container(
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
    } else {
      _initProcessing();

      return Container(
          color: ColorsSdk.bgBlock,
          child: Stack(
              children: [
                Column(
                  children: [
                    AppBar(title: const Text('Оплата заказа', style: TextStyle(fontSize: 16))),
                    const SizedBox(height: 10),
                    airbaPaySdkProcessingView(
                      context: context,
                      backgroundColor: const Color(0xFFFFFFFF),
                      actionOnLoadingCompleted: () {
                        _isLoading = false;
                      }
                    )
                  ],
                ),
                _isLoading ? const Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF319CF3)),
                      ),
                    )) : const SizedBox()

        ])
      );
    }
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
