import 'package:pigeon/pigeon.dart';

class QiniuUploadRequest {
  final String key;
  final String token;
  final String file;

  const QiniuUploadRequest(this.key, this.token, this.file);
}

class QiniuUploadResult {
  final String requestId;
  final QiniuUploadRequest request;

  QiniuUploadResult(this.requestId, this.request);
}

class QiniuTaskUpdate {
  final String requestId;
  final double percent;

  QiniuTaskUpdate(this.requestId, this.percent);
}

class QiniuTaskComplete {
  final String requestId;
  final QiniuFile file;

  QiniuTaskComplete(this.requestId, this.file);
}

class QiniuFile {
  final String hash;
  final String key;
  final String mimeType;
  final int fileSize;

  QiniuFile(this.hash, this.key, this.mimeType, this.fileSize);
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
}

void configurePigeon(PigeonOptions options) {
  options.dartOut = 'lib/src/api.dart';
  options.javaOut = 'android/src/main/kotlin/com/bruce3x/flutter_qiniu_upload/Api.java';
  options.javaOptions.package = 'com.bruce3x.flutter_qiniu_upload';
}
