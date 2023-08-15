import 'package:apay/ui/pages/home/bloc/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/colors_sdk.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class SwitchedSendCheckToEmailWidget extends StatelessWidget {
  const SwitchedSendCheckToEmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return CupertinoSwitch(
        activeColor: ColorsSdk.colorBrandMain,
        thumbColor: ColorsSdk.gray0,
        trackColor: ColorsSdk.gray25,
        value: state.emailState?.switched ?? false,
        onChanged:  (value) {
          EmailEvent emailEvent = EmailEvent(switched: value);
          context
              .read<HomeBloc>()
              .add(emailEvent);
        },
      );
    });
  }
}