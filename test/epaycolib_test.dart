import 'package:epaycolib/common/error.dart';
import 'package:epaycolib/credit_card.dart';
import 'package:epaycolib/tokens/token_request.dart';
import 'package:epaycolib/tokens/token_response.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:epaycolib/epaycolib.dart';

void main() async {
  test('Error when public key is empty', () {
    Epaycolib instance = new Epaycolib();
    expect(
        () => instance.setup("", ""),
        throwsA(predicate((error) =>
            error is EpaycolibError &&
            error.message == "Public key is required")));
  });

  test('Error when private key is empty', () {
    Epaycolib instance = new Epaycolib();
    expect(
        () => instance.setup("PUBLICKEY", ""),
        throwsA(predicate((error) =>
            error is EpaycolibError &&
            error.message == "Private key is required")));
  });

  // Epaycolib epayco = Epaycolib.instance;

  // epayco.setup("addb31a20bb204c51c931043d15334d9",
  //     "a635ba17a60f456ab2182b967d7273cb", true);

  // TokenRequest tokenRequest = epayco
  //     .createTokenRequest(new CreditCard("4575623182290326", 1, 2010, "010"));
  // TokenResponse tokenResponse = await tokenRequest.send();
  // print(tokenResponse);
}
