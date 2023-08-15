import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/constants/strings.dart';
import '../../../../data/data_holder.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class TopInfoWidget extends StatelessWidget {
  const TopInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return _buildWidget(context);
        }
    );
  }

  Widget _buildWidget(BuildContext context) {

    return Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: ColorsSdk.bgMain,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: _initRow(
                      textStart: amountOfPurchase(),
                      textEnd: DataHolder.purchaseAmountFormatted),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: _initRow(
                      textStart: numberOfPurchase(),
                      textEnd: DataHolder.orderNumber),
                )
              ]),
        ));
  }
}

List<Widget> _initRow({
  String textStart = '',
  String textEnd = '',
}) {
  return [
    Text(
      textStart,
      textAlign: TextAlign.start,
      style: Fonts.regular(),
    ),
    Text(textEnd, textAlign: TextAlign.end, style: Fonts.semiBold()),
  ];
}

