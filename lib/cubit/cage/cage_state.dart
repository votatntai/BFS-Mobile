import '../../domain/models/cages.dart';

class CageState {}

class CagesLoadingState extends CageState {}

class CagesSuccessState extends CageState {
  final Cages cages;
  CagesSuccessState(this.cages);
}

class CagesFailedState extends CageState {
  final String message;
  CagesFailedState(this.message);
}

class CageDetailLoadingState extends CageState {}

class CageDetailSuccessState extends CageState {
  final Cage cage;
  CageDetailSuccessState(this.cage);
}

class CageDetailFailedState extends CageState {
  final String message;
  CageDetailFailedState(this.message);
}