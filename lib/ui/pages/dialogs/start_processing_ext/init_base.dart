import 'package:apay/data/utils/navigate_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io' show Platform;

import '../../../../data/constants/strings.dart';
import '../../../../data/data_holder.dart';
import '../../../../data/models/card.dart';
import '../../../../data/network/repository/auth_repository.dart';
import '../../../../data/network/repository/card_repository.dart';
import '../../../resources/colors_sdk.dart';
import '../../../resources/fonts.dart';
import '../../../ui_components/bottom_sheet_header.dart';
import '../../../ui_components/circular_progress_bar.dart';
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
      _onStartProcessing(
          onSuccess: (cards) {
            actionOnLoadingCompleted(cards);
          },
          onError: () {
            actionOnLoadingCompleted(null);
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
        if(Platform.isIOS) initViewStartProcessingAPay(),
        if(Platform.isAndroid) initViewStartProcessingGPay(),
        if (savedCards.isNotEmpty && DataHolder.isAuthenticated)
          initViewStartProcessingCards(
              context: context,
              savedCards: savedCards,
              selected: selected,
              actionClickCard: actionClickCard
          ),
        initViewStartProcessingButtonNext(
            context: context,
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

void _onStartProcessing({
  required void Function(List<BankCard>?) onSuccess,
  required void Function() onError,
}) async {

  try {
    await auth(
        paymentId: null,
        user: DataHolder.shopId,
        password: DataHolder.password,
        terminalId: DataHolder.terminalId,
        accessToken: null);

    CardsGetResponse? response = await getCards(phone: DataHolder.userPhone);
    onSuccess(response?.getCards());
    /*savedCards = response?.getCards() ?? List.empty();
    actionOnLoadingCompleted()

    if (savedCards.isNotEmpty) {
      selectedCard = savedCards[0];
    }*/
  } catch (e) {
    onError();
    // actionOnLoadingCompleted();
  }
}