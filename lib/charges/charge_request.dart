import 'package:epaycolib/charges/charge_response.dart';

class ChargeRequest {
  Future<ChargeResponse> send() async {
    return ChargeResponse.fromResponse();
  }
}
