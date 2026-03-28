import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    getImages(2);
  }
  bool hasMore = true; // * 
  QueryDocumentSnapshot? lastDocument; // * 

  Future<void> getImages(int limit) async {
    if (state.images.isEmpty) {
      emit(HomeState(status: HomeStatus.loading));
    }
    if (hasMore == false) {
      return; // * close
    }
    print('get dan oldin');

    Query<Map<String, dynamic>> result = FirebaseFirestore.instance.collection('photos').limit(limit);
    print('last document $lastDocument');
    if (lastDocument != null) {
      result = result.startAfterDocument(lastDocument!);
    }

    final data = await result.get();

    print('get dan kegin');
    lastDocument = data.docs.last;
    hasMore = data.docs.isNotEmpty;
    final updatedImages = List<QueryDocumentSnapshot<Map>>.from(state.images)
      ..addAll(data.docs);

    print('enit dan oldin');
    emit(HomeState(status: HomeStatus.loaded, images: updatedImages));
    print('enit dan kegin');
  }
}
