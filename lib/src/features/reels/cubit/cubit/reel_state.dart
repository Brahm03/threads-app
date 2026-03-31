part of 'reel_cubit.dart';
// * old value   <->  new value

class ReelState extends Equatable {
  final ReelStatus status;
  final String errorText;
  final List<QueryDocumentSnapshot<Map>> videos;
  const ReelState({this.status = ReelStatus.initial, this.errorText = "", this.videos = const []});

  @override
  List<Object> get props => [status, errorText];
}

enum ReelStatus { initial, loading, loaded, error }
