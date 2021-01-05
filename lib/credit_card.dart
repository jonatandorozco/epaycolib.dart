import 'package:epaycolib/common/error.dart';

class CreditCard {
  final String number;
  final int expMonth;
  final int expYear;
  final String cvc;

  CreditCard(this.number, this.expMonth, this.expYear, this.cvc) {
    if (this.number.length == 0) {
      throw new EpaycolibError("Invalid credit card number");
    }

    if (this.expYear < 1000 || this.expYear > 9999) {
      throw new EpaycolibError("Invalid credit card expiration year");
    }

    if (this.expMonth < 1 || this.expMonth > 12) {
      throw new EpaycolibError("Invalid credit card expiration month");
    }

    if (this.cvc.length != 3) {
      throw new EpaycolibError("Invalid credit card cvc");
    }
  }
}
