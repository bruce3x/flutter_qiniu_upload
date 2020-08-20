import 'package:pigeon/pigeon.dart';

class QiniuUploadRequest {
  final String key;
  final String token;
  final String file;

  const QiniuUploadRequest(this.key, this.token, this.file);
}

class QiniuUploadResult {
  final String requestId;

  QiniuUploadResult(this.requestId);
}

class QiniuTaskUpdate {
  final String requestId;
  final double percent;

  QiniuTaskUpdate(this.requestId, this.percent);
}

class QiniuTaskComplete {
  final String requestId;
  final String hash;
  final String key;

  QiniuTaskComplete(this.requestId, this.hash, this.key);
}

class QiniuTaskCancellation {
  final String requestId;

  QiniuTaskCancellation(this.requestId);
}

class QiniuTaskError {
  final String requestId;
  final String error;
  final int statusCode;

  QiniuTaskError(this.requestId, this.error, this.statusCode);
}

@HostApi()
abstract class QiniuHostApi {
  QiniuUploadResult upload(QiniuUploadRequest request);

  void cancel(QiniuUploadResult result);
}

@FlutterApi()
abstract class QiniuFlutterApi {
  void taskUpdate(QiniuTaskUpdate data);

  void taskComplete(QiniuTaskComplete data);

  void taskCancelled(QiniuTaskCancellation data);

  void taskError(QiniuTaskError data);
}

void configurePigeon(PigeonOptions options) {
  options.dartOut = 'lib/src/api.dart';
  options.javaOut = 'android/src/main/kotlin/com/bruce3x/flutter_qiniu_upload/Api.java';
  options.javaOptions.package = 'com.bruce3x.flutter_qiniu_upload';
}
