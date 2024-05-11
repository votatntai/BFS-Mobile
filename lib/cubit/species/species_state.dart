import '../../domain/models/birdspecies.dart';

class SpeciesState {}

class SpeciesLoadingState extends SpeciesState {}

class SpeciesSuccessState extends SpeciesState {
  final BirdSpecies species;
  SpeciesSuccessState({required this.species});
}

class SpeciesFailedState extends SpeciesState {
  final String msg;
  SpeciesFailedState(this.msg);
}
