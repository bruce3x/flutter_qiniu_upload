// Autogenerated from Pigeon (v0.1.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import
import 'dart:async';
import 'package:flutter/services.dart';

class QiniuUploadResult {
  String requestId;
  QiniuUploadRequest request;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['requestId'] = requestId;
    pigeonMap['request'] = request == null ? null : request._toMap();
    return pigeonMap;
  }
  // ignore: unused_element
  static QiniuUploadResult _fromMap(Map<dynamic, dynamic> pigeonMap) {
    if (pigeonMap == null){
      return null;
    }
    final QiniuUploadResult result = QiniuUploadResult();
    result.requestId = pigeonMap['requestId'];
    result.request = QiniuUploadRequest._fromMap(pigeonMap['request']);
    return result;
  }
}

class QiniuUploadRequest {
  String key;
  String token;
  String file;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['key'] = key;
    pigeonMap['token'] = token;
    pigeonMap['file'] = file;
    return pigeonMap;
  }
  // ignore: unused_element
  static QiniuUploadRequest _fromMap(Map<dynamic, dynamic> pigeonMap) {
    if (pigeonMap == null){
      return null;
    }
    final QiniuUploadRequest result = QiniuUploadRequest();
    result.key = pigeonMap['key'];
    result.token = pigeonMap['token'];
    result.file = pigeonMap['file'];
    return result;
  }
}

class QiniuTaskUpdate {
  String requestId;
  double percent;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['requestId'] = requestId;
    pigeonMap['percent'] = percent;
    return pigeonMap;
  }
  // ignore: unused_element
  static QiniuTaskUpdate _fromMap(Map<dynamic, dynamic> pigeonMap) {
    if (pigeonMap == null){
      return null;
    }
    final QiniuTaskUpdate result = QiniuTaskUpdate();
    result.requestId = pigeonMap['requestId'];
    result.percent = pigeonMap['percent'];
    return result;
  }
}

class QiniuTaskComplete {
  String requestId;
  QiniuFile file;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['requestId'] = requestId;
    pigeonMap['file'] = file == null ? null : file._toMap();
    return pigeonMap;
  }
  // ignore: unused_element
  static QiniuTaskComplete _fromMap(Map<dynamic, dynamic> pigeonMap) {
    if (pigeonMap == null){
      return null;
    }
    final QiniuTaskComplete result = QiniuTaskComplete();
    result.requestId = pigeonMap['requestId'];
    result.file = QiniuFile._fromMap(pigeonMap['file']);
    return result;
  }
}

class QiniuFile {
  String hash;
  String key;
  String mimeType;
  int fileSize;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['hash'] = hash;
    pigeonMap['key'] = key;
    pigeonMap['mimeType'] = mimeType;
    pigeonMap['fileSize'] = fileSize;
    return pigeonMap;
  }
  // ignore: unused_element
  static QiniuFile _fromMap(Map<dynamic, dynamic> pigeonMap) {
    if (pigeonMap == null){
      return null;
    }
    final QiniuFile result = QiniuFile();
    result.hash = pigeonMap['hash'];
    result.key = pigeonMap['key'];
    result.mimeType = pigeonMap['mimeType'];
    result.fileSize = pigeonMap['fileSize'];
    return result;
  }
}

class QiniuHostApi {
  Future<QiniuUploadResult> upload(QiniuUploadRequest arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel =
        BasicMessageChannel<dynamic>('dev.flutter.pigeon.QiniuHostApi.upload', StandardMessageCodec());
    
    final Map<dynamic, dynamic> replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      return QiniuUploadResult._fromMap(replyMap['result']);
    }
    
  }
  Future<void> cancel(QiniuUploadResult arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel =
        BasicMessageChannel<dynamic>('dev.flutter.pigeon.QiniuHostApi.cancel', StandardMessageCodec());
    
    final Map<dynamic, dynamic> replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
    
  }
}

abstract class QiniuFlutterApi {
  void taskUpdate(QiniuTaskUpdate arg);
  void taskComplete(QiniuTaskComplete arg);
  static void setup(QiniuFlutterApi api) {
    {
      const BasicMessageChannel<dynamic> channel =
          BasicMessageChannel<dynamic>('dev.flutter.pigeon.QiniuFlutterApi.taskUpdate', StandardMessageCodec());
      channel.setMessageHandler((dynamic message) async {
        final Map<dynamic, dynamic> mapMessage = message as Map<dynamic, dynamic>;
        final QiniuTaskUpdate input = QiniuTaskUpdate._fromMap(mapMessage);
        api.taskUpdate(input);
      });
    }
    {
      const BasicMessageChannel<dynamic> channel =
          BasicMessageChannel<dynamic>('dev.flutter.pigeon.QiniuFlutterApi.taskComplete', StandardMessageCodec());
      channel.setMessageHandler((dynamic message) async {
        final Map<dynamic, dynamic> mapMessage = message as Map<dynamic, dynamic>;
        final QiniuTaskComplete input = QiniuTaskComplete._fromMap(mapMessage);
        api.taskComplete(input);
      });
    }
  }
}

