import 'package:epaycolib/common/error.dart';
import 'package:epaycolib/credit_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Error when credit card number length is zero", () {
    expect(() {
      new CreditCard("", 0, 0, "");
    },
        throwsA(predicate((error) =>
            error is EpaycolibError &&
            error.message == "Invalid credit card number")));
  });
}
