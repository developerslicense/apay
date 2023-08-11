import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/constants/strings.dart';
import '../../../../data/data_holder.dart';
import '../../../../data/models/card.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../ui_components/bottom_sheet_header.dart';
import '../../../ui_components/circular_progress_bar.dart';
import '../start_processing_bloc/start_processing_bloc.dart';
import '../start_processing_bottom_sheet.dart';
import 'init_amount.dart';
import 'init_button_next.dart';
import 'init_card.dart';
import 'init_gpay.dart';

Widget buildPageStartProcessing({
    required BuildContext context,
    required void Function(List<BankCard>?) actionOnLoadingCompleted,
    required void Function(int) actionClickCard,
    required bool isBottomSheetType,
    required bool isLoading,
    required bool isErrorState,
    required int selected,
    Color backgroundColor = ColorsSdk.bgBlock,
    List<BankCard>? savedCards
}) {

  WidgetsBinding.instance.addPostFrameCallback((_) {

    if(isLoading) {
      onStartProcessing(
          onSuccess: (cards) {
            actionOnLoadingCompleted(cards);
            /* context.read<StartProcessingBloc>().add(
              ChangedStartProcessingEvent(
                  isAuthenticated: context.read<StartProcessingBloc>().state.isAuthenticated,
                  savedCards: cards,
                  isLoaded: isLoading//false
              )
          );*/
          },
          onError: () {
            actionOnLoadingCompleted(null);
            /* context.read<StartProcessingBloc>().add(
              ChangedStartProcessingEvent(
                  isErrorState: true,
                  isLoaded: isLoading //false
              )
          );*/
          }
      );
    }
  });

  return Stack(children: [
        Column(children: [
          if (isBottomSheetType)
            initHeader(
                title: paymentByCard(),
                actionClose: () => {Navigator.of(context).pop()}),
          if (isErrorState) _initErrorState(context),
          if (!isErrorState) _initSuccessState(savedCards ?? [], actionClickCard, selected, context)
        ]),
        isLoading
            ? const Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: ProgressDialogPrimary())
            : const SizedBox()
  ]);
}

Widget _initSuccessState(
    List<BankCard> savedCards,
    void Function(int) actionClickCard,
    int selected,
    BuildContext context,
) {
  return Column(children: [
        initViewStartProcessingAmount(DataHolder.purchaseAmountFormatted),
        initViewStartProcessingGPay(),
        if (savedCards.isNotEmpty && DataHolder.isAuthenticated)
          initViewStartProcessingCards(
              savedCards: savedCards,
              selected: selected,
              actionClickCard: actionClickCard
          ),
        initViewStartProcessingButtonNext(
            savedCards: savedCards,
            purchaseAmount: DataHolder.purchaseAmountFormatted,
            isAuthenticated: DataHolder.isAuthenticated,
            selectedCard: savedCards.firstOrNull)
      ]);
}

Widget _initErrorState(
    BuildContext context,
) {
  double iconSize = MediaQuery.of(context).size.width * 0.6;

  return Column(
    children: [
      SvgPicture.asset(
        'assets/images/something_wrong.svg',
        height: iconSize,
        width: iconSize,
      ),
      const SizedBox(height: 24),
      Text(
        somethingWentWrong(),
        style: Fonts.h3(),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(
            somethingWentWrongDescription(),
            style: Fonts.bodyRegular(),
            textAlign: TextAlign.center,
          ))
    ],
  );
}
