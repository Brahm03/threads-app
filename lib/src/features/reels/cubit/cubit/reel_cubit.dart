import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'reel_state.dart';

class ReelCubit extends Cubit<ReelState> {
  ReelCubit() : super(ReelState()) {
    getVideos(2, () {});
  }

  bool hasMore = true;
  QueryDocumentSnapshot? lastDocument;

  Future<void> getVideos(int limit, Function noMore) async {
    if (state.videos.isEmpty) {
      emit(ReelState(status: ReelStatus.loading));
    }
    if (hasMore == false) {
      noMore(); // * toastification -> snackbar
      return;
    }
    Query<Map<String, dynamic>> result =
        FirebaseFirestore.instance.collection('videos').limit(limit);
    if (lastDocument != null) {
      result = result.startAfterDocument(lastDocument!);
    }
    final data = await result.get();
    hasMore = data.docs.isNotEmpty;
    lastDocument = data.docs.isNotEmpty ? data.docs.last : null;
    hasMore = data.docs.isNotEmpty;
    final updatedVideos = List<QueryDocumentSnapshot<Map>>.from(state.videos)
      ..addAll(data.docs);

    emit(ReelState(status: ReelStatus.loaded, videos: updatedVideos));
  }

  Future<void> onLike(String id, int oldCount) async {
    int count = (oldCount + 1);
    print('count $count old count $oldCount');
    FirebaseFirestore.instance
        .collection('videos')
        .doc(id)
        .update({"likes": (oldCount + 1)}).then((v) {
      emit(ReelState(
          status: ReelStatus.loaded,
          videos: state.videos
              .where((video) => video.id == id
                  ? video.data().update('likes', (v) => (oldCount++))
                  : video.data()['likes'])
              .toList()));
    }).onError((error, stack) {
      print('On like error $error');
    });
  }
}
