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

class BirdDetailLoadingState extends BirdState {}

class BirdDetailSuccessState extends BirdState {
  Bird bird;
  BirdDetailSuccessState({required this.bird});
}

class BirdDetailFailedState extends BirdState {
  final String error;
  BirdDetailFailedState(this.error);
}