part of 'home_cubit.dart';

class HomeState extends Equatable {
  final HomeStatus status;
  final List<QueryDocumentSnapshot<Map>> images;
  const HomeState({this.status = HomeStatus.initial, this.images = const []});

  @override
  List<Object> get props => [
    status,
    HomeStatus.error,
    HomeStatus.loaded,
    HomeStatus.loading,
    images
  ];
}

enum HomeStatus { initial, loaded, loading, error }
