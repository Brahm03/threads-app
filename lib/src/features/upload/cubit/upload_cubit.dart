import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_app/src/core/utils/environment.dart';
import 'package:threads_app/src/features/upload/cubit/upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadState());

  void pickMedia() async {
    try {
      final result =
          await ImagePicker().pickMultiImage(limit: 5, imageQuality: 90);
      List<File> rasmlar = [];

      for (var i = 0; i < result.length; i++) {
        rasmlar.add(File(result[i].path));
      }

      if (result.isNotEmpty) {
        emit(UploadState(status: UploadStatus.initial, pictures: rasmlar));
      } else {
        print('Error on media $result');
      }
    } catch (e) {
      print('Error on media $e');
    }
  }

  void uploadMedia() async {
    // * pick -> initial [file, file]
    // * loading -> [] -> appwrite
    // * loading X
    try {
      if (state.pictures.isEmpty) {
        emit(UploadState(status: UploadStatus.error, errorText: 'Rasm tanlanmadi !'));
      } else {
        final uploadTasks = state.pictures.map((picture) {
          return Environment.instance.storage.createFile(
            bucketId: Environment.instance.bucketID,
            fileId: ID.unique(),
            file: InputFile.fromPath(
                path: picture.path, filename: "${DateTime.now()}.png"),
          );
        }).toList();

        await Future.wait(uploadTasks);

        emit(UploadState(status: UploadStatus.loaded));
      }
    } on AppwriteException catch (e) {
      print('error on uploaded $e');
      emit(UploadState(
          status: UploadStatus.error,
          errorText: e.message ?? 'Something went wrong !'));
    }
  }
}
