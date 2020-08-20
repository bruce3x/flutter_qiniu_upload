import 'package:flutter/material.dart';

@immutable
class QiniuFile {
  final String hash;
  final String key;

  const QiniuFile(this.hash, this.key);
}

class QiniuProgress {
  final double percent;
  final QiniuFile file;

  bool get isCompleted => file != null;

  QiniuProgress._(this.percent, this.file);

  QiniuProgress.progress(double percent) : this._(percent, null);

  QiniuProgress.complete(QiniuFile file) : this._(1, file);
}
