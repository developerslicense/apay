import 'package:flutter/cupertino.dart';

import 'package:apay/ui/resources/colors_sdk.dart';

class Fonts {
  static TextStyle regular() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: ColorsSdk.textMain,
        fontSize: 14.0,
        height: 1.57);
  }

  static TextStyle bodyRegular() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: ColorsSdk.textMain,
        fontSize: 16.0,
        height: 1.5);
  }

  static TextStyle caption400() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: ColorsSdk.textMain,
        fontSize: 12.0,
        height: 1.5);
  }

  static TextStyle subtitleBold() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        color: ColorsSdk.textMain,
        fontSize: 16.0,
        height: 1.5);
  }

  static TextStyle semiBold() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: ColorsSdk.textMain,
        fontSize: 14.0,
        height: 1.57);
  }

  static TextStyle h1() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        color: ColorsSdk.textMain,
        fontSize: 24.0,
        height: 1.6);
  }

  static TextStyle h2() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: ColorsSdk.textMain,
        fontSize: 20.0,
        height: 1.2);
  }

  static TextStyle h3() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        color: ColorsSdk.textMain,
        fontSize: 20.0,
        height: 1.5);
  }

  static TextStyle h4() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        color: ColorsSdk.textMain,
        fontSize: 15.0,
        height: 1.3);
  }

  static TextStyle note() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: ColorsSdk.textMain,
        fontSize: 10.0,
        height: 1.2);
  }

  static TextStyle button() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: ColorsSdk.textMain,
        fontSize: 15.0,
        height: 1.6);
  }

  static TextStyle buttonSmall() {
    return const TextStyle(
        fontFamily: 'Monserrat',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: ColorsSdk.textMain,
        fontSize: 13.0,
        height: 1.5);
  }
}


