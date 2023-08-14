import 'package:apay/ui/screens/dialogs/start_processing_bloc/start_processing_bloc.dart';
import 'package:apay/ui/screens/dialogs/start_processing_ext/init_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/card.dart';

class StartProcessingBottomSheet extends StatefulWidget {
  const StartProcessingBottomSheet({super.key});

  @override
  State<StartProcessingBottomSheet> createState() => _StartProcessingBottomSheet();
}

class _StartProcessingBottomSheet extends State<StartProcessingBottomSheet> {
  var _isLoading = true;
  var _selected = 0;
  List<BankCard>? _savedCards;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => StartProcessingBloc(),
      child: Builder(
          builder: (context) => buildPageStartProcessing(
                context: context,
                isBottomSheetType: true,
                isLoading: _isLoading,
                isErrorState: context.read<StartProcessingBloc>().state.isErrorState,
                selected: _selected,
                savedCards: _savedCards,
                actionClickCard: (selected) {
                  setState(() {
                    _selected = selected;
                  });
                },
                actionOnLoadingCompleted: (cards) {
                  if(_isLoading) {
                    setState(() {
                      _savedCards = cards;
                      _isLoading = false;
                    });
                  }
                },
              )),
    );
  }
}
