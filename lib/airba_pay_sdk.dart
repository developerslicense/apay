import 'package:apay/data/utils/navigate_utils.dart';
import 'package:apay/ui/themes/colors.dart';
import 'package:flutter/material.dart';

import 'data/constants/routes.dart';
import 'data/data_holder.dart';
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

  static void startProcessing({
    required BuildContext context,
    required bool isProd,
    required int purchaseAmount,
    required String phone,
    required String orderNumber,
    required String invoiceId,
    required String shopId,
    required String password,
    required String terminalId,
    required String failureBackUrl,
    required String failureCallback,
    required String successBackUrl,
    required String successCallback,
    required List<Goods> goods,
    required List<SettlementPayment>? settlementPayment,
    String? userEmail,
    int connectTimeout = 60,
    int receiveTimeout = 60,
    int sendTimeout = 60,
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

    DataHolder.failureBackUrl = failureBackUrl;
    DataHolder.failureCallback = failureCallback;
    DataHolder.successBackUrl = successBackUrl;
    DataHolder.successCallback = successCallback;

    DataHolder.sendTimeout = sendTimeout;
    DataHolder.connectTimeout = connectTimeout;
    DataHolder.receiveTimeout = receiveTimeout;
    DataHolder.shopId = shopId;
    DataHolder.password = password;
    DataHolder.terminalId = terminalId;
    DataHolder.purchaseAmount = Money(purchaseAmount).getFormatted();
    DataHolder.orderNumber = orderNumber;
    DataHolder.invoiceId = invoiceId;

    DataHolder.goods = goods;
    DataHolder.settlementPayments = settlementPayment;

    DataHolder.currentLang = lang.lang;

    if(colorBrandInversion != null) {
      ColorsSdk.colorBrandInversion = colorBrandInversion;
    }

    if(colorBrandMain != null) {
      ColorsSdk.colorBrandMain = colorBrandMain;
    }

    openHome(context);
  }
}