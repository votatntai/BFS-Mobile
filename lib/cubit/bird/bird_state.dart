import '../../domain/models/birds.dart';

class BirdState {}

class BirdLoadingState extends BirdState {}

class BirdSuccessState extends BirdState {
  Birds birds;
  BirdSuccessState({required this.birds});
}

class BirdFailedState extends BirdState {
  final String error;
  BirdFailedState(this.error);
}
