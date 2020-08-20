class UploadException implements Exception {
  final String message;
  final int code;

  UploadException(this.message, this.code);

  @override
  String toString() {
    return 'UploadException{message: $message, code: $code}';
  }
}

class UploadCancellation implements Exception {
  @override
  String toString() {
    return 'UploadCancellation{}';
  }
}
