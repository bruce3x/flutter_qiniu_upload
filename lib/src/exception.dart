/// Upload request error
/// [code] refer https://github.com/qiniu/android-sdk/blob/master/library/src/main/java/com/qiniu/android/http/ResponseInfo.java
class UploadException implements Exception {
  final String message;
  final int code;

  UploadException(this.message, this.code);

  @override
  String toString() {
    return 'UploadException{message: $message, code: $code}';
  }
}

/// Upload request cancelled
class UploadCancellation implements Exception {
  @override
  String toString() {
    return 'UploadCancellation{}';
  }
}
