import 'package:apay/ui/screens/dialogs/start_processing_bloc/start_processing_bloc.dart';
import 'package:apay/ui/screens/dialogs/start_processing_bloc/start_processing_event.dart';
import 'package:apay/ui/screens/dialogs/start_processing_ext/init_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_holder.dart';
import '../../../data/models/card.dart';
import '../../../data/network/repository/auth_repository.dart';
import '../../../data/network/repository/card_repository.dart';

class StartProcessingBottomSheet extends StatefulWidget {
  const StartProcessingBottomSheet({super.key});

  @override
  State<StartProcessingBottomSheet> createState() => _StartProcessingBottomSheet();
}

class _StartProcessingBottomSheet extends State<StartProcessingBottomSheet> {
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => StartProcessingBloc(),
      child: Builder(
          builder: (context) => buildPageStartProcessing(
                context: context,
                isBottomSheetType: true,
                isAuthenticated: context.read<StartProcessingBloc>().state.isAuthenticated,
                isLoading: _isLoading,
                isErrorState: context.read<StartProcessingBloc>().state.isErrorState,
                actionOnLoadingCompleted: () {
                  if(_isLoading) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
              )),
    );
  }
}


void onStartProcessing({
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