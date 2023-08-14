import 'package:apay/ui/screens/dialogs/start_processing_bottom_sheet.dart';
import 'package:apay/ui/themes/colors.dart';
import 'package:flutter/material.dart';

import 'data/data_holder.dart';
import 'data/utils/airba_pay_biometric.dart';
import 'data/utils/money_utlis.dart';

enum AirbaPaySdkLang {
  ru('ru'),
  kz('kz');

  const AirbaPaySdkLang(this.lang);
  final String lang;
}

class SettlementPayment {
  int? amount;
  String? companyId;
}

class Goods {
  String? brand;
  String? category;
  String? model;
  int? discount;
  int? quantity;
  int? price;

  Goods({
    this.brand,
    this.quantity,
    this.price,
    this.model,
    this.discount,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      "brand": brand,
      "category": category,
      "discount": discount,
      "model": model,
      "price": price,
      "quantity": quantity
    };
  }
}

class AirbaPaySdk {

  static void initOnCreate({
    required bool isProd,
    required String phone,
    required String shopId,
    required String password,
    required String terminalId,
    required String failureCallback,
    required String successCallback,
    String? userEmail,
    AirbaPaySdkLang lang = AirbaPaySdkLang.ru,
    Color? colorBrandMain,
    Color? colorBrandInversion,
  }) {
    DataHolder.bankName = null;
    DataHolder.accessToken = null;
    DataHolder.isProd = isProd;
    DataHolder.baseUrl = isProd ? 'https://ps.airbapay.kz/acquiring-api/sdk' : 'https://sps.airbapay.kz/acquiring-api/sdk';

    DataHolder.userPhone = phone;
    DataHolder.userEmail = userEmail;

    DataHolder.failureCallback = failureCallback;
    DataHolder.successCallback = successCallback;

    DataHolder.shopId = shopId;
    DataHolder.password = password;
    DataHolder.terminalId = terminalId;

    DataHolder.currentLang = lang.lang;

    if(colorBrandInversion != null) {
      ColorsSdk.colorBrandInversion = colorBrandInversion;
    }

    if(colorBrandMain != null) {
      ColorsSdk.colorBrandMain = colorBrandMain;
    }
  }

  static void initProcessing({
    required int purchaseAmount,
    required String invoiceId,
    required String orderNumber,
    required List<Goods> goods,
    required List<SettlementPayment>? settlementPayments
  }) {
    DataHolder.isAuthenticated = false;

    DataHolder.purchaseAmount = purchaseAmount.toString();
    DataHolder.orderNumber = orderNumber;
    DataHolder.invoiceId = invoiceId;
    DataHolder.goods = goods;
    DataHolder.settlementPayments = settlementPayments;

    DataHolder.purchaseAmountFormatted = Money(purchaseAmount).getFormatted();
  }
}

void airbaPaySdkProcessingBottomSheet({
  required BuildContext context
}) {
  var airbaPayBiometric = AirbaPayBiometric();

  airbaPayBiometric.authenticate(
    context: context,
    onResult: (){
      showModalBottomSheet(
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: ColorsSdk.bgBlock,
          context: context,
          builder: (context) {
        return const StartProcessingBottomSheet();
      });
    }
  );
}
