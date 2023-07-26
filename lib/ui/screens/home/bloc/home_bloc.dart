import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(const HomeState()) {
    on<SwitchedSaveCardDataEvent>(_onChangeSaveCard);

    on<EmailEvent>(_onEventTextFieldEmail);
    on<CardNumberEvent>(_onEventTextFieldCardNumber);
    on<NameHolderEvent>(_onEventTextFieldNameHolder);
    on<CvvEvent>(_onEventTextFieldCvv);
    on<DateExpiredEvent>(_onEventTextFieldDateExpired);

    on<EmailDataEvent>(_onEventDataEmail);
    on<NameHolderDataEvent>(_onEventDataNameHolder);
    on<CvvDataEvent>(_onEventDataCvv);
    on<DateExpiredDataEvent>(_onEventDataDateExpired);
    on<CardNumberDataEvent>(_onEventDataCardNumber);

    on<PaymentProcessingEvent>(_onPaymentProcessing);
  }

///////////
  void _onEventDataNameHolder(
      NameHolderDataEvent event,
      Emitter<HomeState> emit
  ) async {

    emit(state.copyWith(nameHolder: event.nameHolder));
  }

  void _onEventDataDateExpired(
      DateExpiredDataEvent event,
      Emitter<HomeState> emit
  ) async {

    emit(state.copyWith(dateExpired: event.dateExpired));
  }

  void _onEventDataEmail(
      EmailDataEvent event,
      Emitter<HomeState> emit
  ) async {

    emit(state.copyWith(email: event.email));
  }

  void _onEventDataCardNumber(
      CardNumberDataEvent event,
      Emitter<HomeState> emit
  ) async {

    emit(state.copyWith(
        cardNumber: event.cardNumber,
        iconPaymentSystem: event.iconPaymentSystem
    ));
  }

  void _onEventDataCvv(
      CvvDataEvent event,
      Emitter<HomeState> emit
  ) async {

    emit(state.copyWith(cvv: event.cvv));
  }

/////////////

  void _onEventTextFieldEmail(
      EmailEvent event,
      Emitter<HomeState> emit
  ) async {

    EmailTextFieldState textState = EmailTextFieldState(
      switched: event.switched,
      error: event.errorEmail
    );

    emit(state.copyWith(emailState: textState));
  }

 void _onEventTextFieldCardNumber(
     CardNumberEvent event,
     Emitter<HomeState> emit
  ) async {

   CardNumberTextFieldState textState = CardNumberTextFieldState(
      error: event.errorCardNumber
    );

    emit(state.copyWith(cardNumberState: textState));
  }

 void _onEventTextFieldNameHolder(
      NameHolderEvent event,
      Emitter<HomeState> emit
  ) async {

    NameHolderTextFieldState textState = NameHolderTextFieldState(
      error: event.errorNameHolder
    );

    emit(state.copyWith(nameHolderState: textState));
  }

 void _onEventTextFieldCvv(
      CvvEvent event,
      Emitter<HomeState> emit
  ) async {

    CvvTextFieldState textState = CvvTextFieldState(
      error: event.errorCvv
    );

    emit(state.copyWith(cvvState: textState));
  }

 void _onEventTextFieldDateExpired(
      DateExpiredEvent event,
      Emitter<HomeState> emit
  ) async {

    DateExpiredTextFieldState textState = DateExpiredTextFieldState(
      error: event.errorDateExpired
    );

    emit(state.copyWith(dateExpiredState: textState));
  }

  void _onChangeSaveCard(
      SwitchedSaveCardDataEvent event,
      Emitter<HomeState> emit
  ) async {

    emit(state.copyWith(saveCardData: event.switched));
  }

 void _onPaymentProcessing(
      PaymentProcessingEvent event,
      Emitter<HomeState> emit
  ) async {

    emit(state.copyWith(isPaymentProcessing: event.isPaymentProcessing));
  }

}
