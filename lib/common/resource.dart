import 'dart:convert';

import 'package:epaycolib/common/error.dart';
import 'package:epaycolib/epaycolib.dart';
import 'package:http/http.dart';

class Resource {
  final Epaycolib epayco;
  String baseUrl = "https://api.secure.payco.co";
  String url;
  ResourceMethod method;
  Map<String, dynamic> body;
  bool needAuth;
  String _token;

  Resource(this.epayco);

  bool authenticatedResponse(Map<String, dynamic> response) {
    bool status = response["status"];
    String message = response["message"];
    if (status == false &&
        message ==
            "Llave pública o token de autenticación invalido o expirado") {
      return false;
    }
  }

  Future<void> authenticate() async {
    Resource authResource = new Resource(this.epayco);
    authResource.url = "/v1/auth/login";
    authResource.method = ResourceMethod.POST;
    authResource.body = {
      "public_key": epayco.publicKey,
      "private_key": epayco.privateKey
    };
    authResource.needAuth = false;
    Map<String, dynamic> response = await authResource.getResponse();
    bool status = response["status"];
    String message = response["message"];
    if (status == false) {
      if (message == "Error validando las llaves del comercio") {
        throw new EpaycolibError("Invalid setup");
      } else {
        throw new EpaycolibError("Unkown error");
      }
    } else {
      this._token = response["bearer_token"];
    }
  }

  Future<Map<String, dynamic>> getResponse() async {
    Response response;
    if (this.needAuth) {
      await this.authenticate();
    }
    switch (this.method) {
      case ResourceMethod.DELETE:
        if (this.needAuth == true) {
          response = await delete("${this.baseUrl}${this.url}", headers: {
            "Authorization": "Bearer ${this._token}",
            "Type": "sdk-jwt"
          });
        } else {
          response = await delete("${this.baseUrl}${this.url}");
        }
        break;
      case ResourceMethod.GET:
        response = await get("${this.baseUrl}${this.url}");
        break;
      case ResourceMethod.PATCH:
        response = await patch("${this.baseUrl}${this.url}");
        break;
      case ResourceMethod.POST:
        if (this.body != null) {
          if (this.epayco.test) {
            this.body["test"] = "TRUE";
          }
          if (this.needAuth) {
            response = await post("${this.baseUrl}${this.url}",
                body: jsonEncode(this.body),
                headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer ${this._token}",
                  "Type": "sdk-jwt"
                });
          } else {
            response = await post("${this.baseUrl}${this.url}",
                body: jsonEncode(this.body),
                headers: {"Content-Type": "application/json"});
          }
        } else {
          if (this.needAuth) {
            response = await post("${this.baseUrl}${this.url}", headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${this._token}",
              "Type": "sdk-jwt"
            });
          } else {
            response = await post("${this.baseUrl}${this.url}");
          }
        }
        break;
      case ResourceMethod.PUT:
        response = await put("${this.baseUrl}${this.url}");
        break;
    }
    Map<String, dynamic> data =
        response != null ? jsonDecode(utf8.decode(response.bodyBytes)) : null;
    if (data == null) {
      throw new EpaycolibError("No response");
    }

    print(data);

    return data;
  }
}

enum ResourceMethod { DELETE, GET, PATCH, POST, PUT }
