import 'card_type.dart';

class PaymentCard {
  CardType type;
  String number;
  String name;
  int month;
  int year;
  int cvv;

  PaymentCard(
      this.type,
      this.number,
      this.name,
      this.month,
      this.year,
      this.cvv
  );
}