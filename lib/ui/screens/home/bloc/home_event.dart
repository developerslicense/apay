import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

/////////////

final class EmailDataEvent extends HomeEvent {
  const EmailDataEvent({this.email});

  final String? email;

  @override
  List<Object> get props => ['EmailDataEvent'];
}

final class CardNumberDataEvent extends HomeEvent {
  const CardNumberDataEvent({this.cardNumber, this.iconPaymentSystem});

  final String? cardNumber;
  final String? iconPaymentSystem;

  @override
  List<Object> get props => ['CardNumberDataEvent'];
}

final class CvvDataEvent extends HomeEvent {
  const CvvDataEvent({this.cvv});

  final String? cvv;

  @override
  List<Object> get props => ['CvvDataEvent'];
}

final class NameHolderDataEvent extends HomeEvent {
  const NameHolderDataEvent({this.nameHolder});

  final String? nameHolder;

  @override
  List<Object> get props => ['NameHolderDataEvent'];
}

final class DateExpiredDataEvent extends HomeEvent {
  const DateExpiredDataEvent({this.dateExpired});

  final String? dateExpired;

  @override
  List<Object> get props => ['DateExpiredDataEvent'];
}

//////////////

final class EmailEvent extends HomeEvent {

  const EmailEvent({
    this.errorEmail,
    this.switched = false
  });

  final String? errorEmail;
  final bool switched;


  @override
  List<Object> get props => ['errorEmail=$errorEmail'];
}

final class CardNumberEvent extends HomeEvent {
  const CardNumberEvent({this.errorCardNumber});

  final String? errorCardNumber;

  @override
  List<Object> get props => ['errorCardNumber=$errorCardNumber'];
}

final class NameHolderEvent extends HomeEvent {
  const NameHolderEvent({this.errorNameHolder});

  final String? errorNameHolder;

  @override
  List<Object> get props => ['errorNameHolder=$errorNameHolder'];
}

final class CvvEvent extends HomeEvent {
  const CvvEvent({this.errorCvv,});

  final String? errorCvv;

  @override
  List<Object> get props => ['errorCvv=$errorCvv'];
}

final class DateExpiredEvent extends HomeEvent {
  const DateExpiredEvent({this.errorDateExpired,});

  final String? errorDateExpired;

  @override
  List<Object> get props => ['errorDateExpired=$errorDateExpired'];
}

final class SwitchedSaveCardDataEvent extends HomeEvent {
  const SwitchedSaveCardDataEvent({required this.switched});

  final bool switched;

  @override
  List<Object> get props => ['SwitchedSaveCardDataEvent=$switched'];
}

final class PaymentProcessingEvent extends HomeEvent {
  const PaymentProcessingEvent({required this.isPaymentProcessing});

  final bool isPaymentProcessing;

  @override
  List<Object> get props => ['PaymentProcessingEvent=$isPaymentProcessing'];
}

