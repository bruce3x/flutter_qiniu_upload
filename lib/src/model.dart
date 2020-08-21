import 'package:flutter/material.dart';

@immutable
class QiniuFile {
  final String hash;
  final String key;

  const QiniuFile(this.hash, this.key);
}

/// [percent] from 0.0 to 1.0
@immutable
class QiniuProgress {
  final double percent;
  final QiniuFile file;

  bool get isCompleted => file != null;

  const QiniuProgress._(this.percent, this.file);

  const QiniuProgress.progress(double percent) : this._(percent, null);

  const QiniuProgress.complete(QiniuFile file) : this._(1, file);
}
