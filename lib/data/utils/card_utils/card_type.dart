enum CardType {
  mir('assets/images/mir.svg'),
  masterCard('assets/images/MasterCard.svg'),
  maestro('assets/images/maestro-card.svg'),
  visa('assets/images/Visa.svg'),
  americanExpress('assets/images/AmericanExpress.svg'),
  chinaUnionPay('assets/images/union-pay.svg'),
  invalid('');
  
  const CardType(this.icon);
  final String icon;

  String get description => name;
}