library epaycolib;

import 'package:epaycolib/common/error.dart';
import 'package:epaycolib/credit_card.dart';
import 'package:epaycolib/token.dart';
import 'package:epaycolib/tokens/token_request.dart';

class Epaycolib {
  String publicKey;
  String privateKey;
  bool test;

  static Epaycolib instance = new Epaycolib();

  void setup(String publicKey, String privateKey, [bool test = false]) {
    if (publicKey.length == 0) {
      throw new EpaycolibError("Public key is required");
    }
    if (privateKey.length == 0) {
      throw new EpaycolibError("Private key is required");
    }
    this.publicKey = publicKey;
    this.privateKey = privateKey;
    this.test = test;
  }

  TokenRequest createTokenRequest(CreditCard creditCard) {
    return new TokenRequest(this, creditCard);
  }
}
