import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

void exitSdk(
    BuildContext context
) {
  Navigator.popUntil(context, (route) => route.isFirst);
}