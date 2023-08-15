enum CardType {
  mir('assets/images/mir.svg'),
  masterCard('assets/images/master_card.svg'),
  maestro('assets/images/maestro_card.svg'),
  visa('assets/images/visa.svg'),
  americanExpress('assets/images/american_express.svg'),
  chinaUnionPay('assets/images/union_pay.svg'),
  invalid('');
  
  const CardType(this.icon);
  final String icon;

  String get description => name;
}