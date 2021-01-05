class TokenResponse {
  bool success;
  String message;
  String status;
  String error;
  String token;

  static TokenResponse fromResponse(Map<String, dynamic> response) {
    TokenResponse instance = new TokenResponse();
    instance.success = response["status"];
    instance.message = response["message"];

    if (response["data"] != null && response["data"] is Map) {
      instance.status = response["data"]["status"];
      instance.error = response["data"]["errors"];
    }

    if (instance.status != null && instance.status == "exitoso") {
      instance.token = response["id"];
    }

    return instance;
  }

  @override
  String toString() {
    return {
      "success": this.success,
      "message": this.message,
      "status": this.status,
      "error": this.error,
      "token": this.token
    }.toString();
  }
}
