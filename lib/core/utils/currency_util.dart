class CurrencyTypes {
  static const String pounds = 'GBP';
  static const String euros = 'EUR';
  static const String cad = 'CAD';
  static const String usd = 'USD';
  static const String ngn = 'NGN';
}

class CurrencySigns {
  static const String pounds = '£';
  static const String euros = '€';
  static const String cad = '\$';
  static const String usd = cad;
  static const String ngn = '₦';
}

selectedCurrencySign(String selectedCurrencyValue) {
  switch (selectedCurrencyValue) {
    case CurrencyTypes.ngn:
      return CurrencySigns.ngn;

    case CurrencyTypes.cad:
      return CurrencySigns.cad;

    case CurrencyTypes.usd:
      return CurrencySigns.usd;

    case CurrencyTypes.pounds:
      return CurrencySigns.pounds;
    case CurrencyTypes.euros:
      return CurrencySigns.euros;

    default:
      return CurrencySigns.ngn;
  }
}
