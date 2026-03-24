import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app/src/features/main/cubit/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());

  int currentIndex(MainStatus status) {
    switch (status) {
      case MainStatus.home:
        return 0;
      case MainStatus.search:
        return 1;
      case MainStatus.like:
        return 2;
      case MainStatus.profile:
        return 3;
      default:
        return 0;
    }
  }

  void onBottomTap(int index) {
    switch (index) {
      case 0:
        emit(MainState(status: MainStatus.home));
        break;
      case 1:
        emit(MainState(status: MainStatus.search));
        break;
      case 2:
        emit(MainState(status: MainStatus.like));
        break;
      case 3:
        emit(MainState(status: MainStatus.profile));
        break;
    }
  }
}
