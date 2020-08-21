# flutter_qiniu_upload

![support-android](https://img.shields.io/badge/support-Android-green)
![pub](https://img.shields.io/pub/v/flutter_qiniu_upload)
![stars](https://img.shields.io/github/stars/bruce3x/flutter_qiniu_upload)
![license](https://img.shields.io/github/license/bruce3x/flutter_qiniu_upload)

A flutter plugin for Qiniu file upload. Support multiple file uploads, listen progress and cancel uploads. 

七牛文件上传插件，支持多文件上传、监听进度和取消上传。

## Getting Started

### 初始化

```dart
QiniuUpload.initialize();
```


### 直接上传

```dart
final qiniuFile = await QiniuUpload.uploadDirectly(file, uploadToken, key);
```


### 监听进度
```dart
final requestId = await QiniuUpload.upload(file, uploadToken, key);
QiniuUpload.progress(requestId).listen((progress) {
  print(progress.percent);
});
```

### 取消上传

```dart
final requestId = await QiniuUpload.upload(file, uploadToken, key);
QiniuUpload.cancel(requestId);
```
