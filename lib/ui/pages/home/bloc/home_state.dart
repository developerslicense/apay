class HomeState {

  const HomeState({
    this.emailState,
    this.dateExpiredState,
    this.cvvState,
    this.nameHolderState,
    this.cardNumberState,

    this.iconPaymentSystem,

    this.cardNumber,
    this.nameHolder,
    this.cvv,
    this.dateExpired,
    this.email,

    this.saveCardData = false,
    this.isPaymentProcessing = false
  });


  final EmailTextFieldState? emailState;
  final CardNumberTextFieldState? cardNumberState;
  final NameHolderTextFieldState? nameHolderState;
  final CvvTextFieldState? cvvState;
  final DateExpiredTextFieldState? dateExpiredState;

  final bool saveCardData;
  final bool isPaymentProcessing;

  final String? iconPaymentSystem;

  final String? cardNumber;
  final String? nameHolder;
  final String? cvv;
  final String? email;
  final String? dateExpired;

  HomeState copyWith({
    EmailTextFieldState? emailState,
    DateExpiredTextFieldState? dateExpiredState,
    CardNumberTextFieldState? cardNumberState,
    CvvTextFieldState? cvvState,
    NameHolderTextFieldState? nameHolderState,
    bool? saveCardData,
    bool? isPaymentProcessing,

    String? purchaseAmount,
    String? orderNumber,

    String? iconPaymentSystem,

    String? cardNumber,
    String? nameHolder,
    String? email,
    String? cvv,
    String? dateExpired
  }) {
    return HomeState(
      emailState: emailState ?? this.emailState,
      cardNumberState: cardNumberState ?? this.cardNumberState,
      dateExpiredState: dateExpiredState ?? this.dateExpiredState,
      cvvState: cvvState ?? this.cvvState,
      nameHolderState: nameHolderState ?? this.nameHolderState,

      saveCardData: saveCardData ?? this.saveCardData,
      isPaymentProcessing: isPaymentProcessing ?? this.isPaymentProcessing,

      iconPaymentSystem: iconPaymentSystem ?? this.iconPaymentSystem,

      cardNumber: cardNumber ?? this.cardNumber,
      nameHolder: nameHolder ?? this.nameHolder,
      email: email ?? this.email,
      cvv: cvv ?? this.cvv,
      dateExpired: dateExpired ?? this.dateExpired,
    );
  }
}

class EmailTextFieldState{
  const EmailTextFieldState({
    this.switched = false,
    this.error
  });

  final bool? switched;
  final String? error;

  EmailTextFieldState copyWith({
    bool? switched,
    String? error
  }) {
    return EmailTextFieldState(
        switched: switched ?? this.switched,
        error: error ?? this.error
    );
  }
}

class CardNumberTextFieldState{
  const CardNumberTextFieldState({this.iconPaymentSystem, this.error});

  final String? error;
  final String? iconPaymentSystem;

  CardNumberTextFieldState copyWith({String? iconPaymentSystem, String? error}) {
    return CardNumberTextFieldState(
        error: error ?? this.error,
        iconPaymentSystem: iconPaymentSystem ?? this.iconPaymentSystem
    );
  }
}

class NameHolderTextFieldState{
  const NameHolderTextFieldState({this.error});

  final String? error;

  NameHolderTextFieldState copyWith({String? error}) {
    return NameHolderTextFieldState(
        error: error ?? this.error
    );
  }
}

class DateExpiredTextFieldState{
  const DateExpiredTextFieldState({this.error});

  final String? error;

  DateExpiredTextFieldState copyWith({String? error}) {
    return DateExpiredTextFieldState(
        error: error ?? this.error
    );
  }
}

class CvvTextFieldState{
  const CvvTextFieldState({this.error});

  final String? error;

  CvvTextFieldState copyWith({String? error}) {
    return CvvTextFieldState(
        error: error ?? this.error
    );
  }
}

