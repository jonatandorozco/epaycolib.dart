import 'package:epaycolib/common/resource.dart';
import 'package:epaycolib/credit_card.dart';
import 'package:epaycolib/epaycolib.dart';
import 'package:epaycolib/tokens/token_response.dart';

class TokenRequest extends Resource {
  final CreditCard creditCard;

  TokenRequest(Epaycolib epayco, this.creditCard) : super(epayco) {
    this.url = "/v1/tokens";
    this.method = ResourceMethod.POST;
    this.needAuth = true;

    this.body = {
      "card[number]": this.creditCard.number,
      "card[exp_month]": this.creditCard.expMonth.toString().padLeft(2, "0"),
      "card[exp_year]": this.creditCard.expYear.toString(),
      "card[cvc]": this.creditCard.cvc
    };
  }

  Future<TokenResponse> send() async {
    Map<String, dynamic> response = await this.getResponse();
    // print(response);
    return TokenResponse.fromResponse(response);
  }
}
