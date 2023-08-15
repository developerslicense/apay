import 'package:apay/data/models/card.dart';

class StartProcessingState {
  const StartProcessingState({
    this.isLoading = false,
    this.isErrorState = false,
    this.isAuthenticated = false,
    this.savedCards
  });

  final bool isLoading;
  final bool isErrorState;
  final bool isAuthenticated;
  final List<BankCard>? savedCards;

  StartProcessingState copyWith({
    bool isLoading = false,
    bool isErrorState = false,
    required bool isAuthenticated,
    List<BankCard>? savedCards
  }) {
    return StartProcessingState(
      isLoading: isLoading,
      savedCards: savedCards,
      isAuthenticated: isAuthenticated,
      isErrorState: isErrorState
    );
  }
}
