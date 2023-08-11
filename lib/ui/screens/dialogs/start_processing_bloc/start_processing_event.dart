import 'package:equatable/equatable.dart';

import '../../../../data/models/card.dart';

sealed class StartProcessingEvent extends Equatable {
  const StartProcessingEvent();

  @override
  List<Object> get props => [];
}

final class ChangedStartProcessingEvent extends StartProcessingEvent {
  const ChangedStartProcessingEvent({
    this.isLoaded = true,
    this.isErrorState = false,
    this.isAuthenticated = false,
    this.savedCards
  });

  final bool isLoaded;
  final bool isErrorState;
  final bool isAuthenticated;
  final List<BankCard>? savedCards;

  @override
  List<Object> get props => ['ChangedStartProcessingEvent'];
}