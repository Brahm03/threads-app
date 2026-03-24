import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadState extends Equatable{
  UploadStatus status;
  String errorText;
  List<File> pictures;
  UploadState({
    this.pictures = const [],
    this.status = UploadStatus.initial,
    this.errorText = '',
  });

  @override
  List<Object?> get props => [
    status,
    errorText,
    pictures
  ];
}

enum UploadStatus { initial, loaded, loading, error }
