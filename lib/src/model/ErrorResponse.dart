class ErrorResponse implements Exception {
  final String code;
  final String message;

  ErrorResponse({this.code, this.message});
}
