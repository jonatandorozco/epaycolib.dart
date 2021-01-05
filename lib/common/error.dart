class EpaycolibError extends Error {
  final String message;
  EpaycolibError(this.message);

  @override
  String toString() {
    return this.message;
  }
}
