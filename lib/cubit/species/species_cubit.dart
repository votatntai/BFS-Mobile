import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/species_repo.dart';
import '../../utils/get_it.dart';
import 'species_state.dart';

class SpeciesCubit extends Cubit<SpeciesState> {
  final SpeciesRepo _speciesRepo = getIt<SpeciesRepo>();

  SpeciesCubit() : super(SpeciesState());

  Future<void> getSpecies({String? name, int? pageNumber, int? pageSize}) async {
    emit(SpeciesLoadingState());
    try {
      var species = await _speciesRepo.getSpecies(name: name, pageNumber: pageNumber, pageSize: pageSize);
      emit(SpeciesSuccessState(species: species));
    } catch (e) {
      emit(SpeciesFailedState(e.toString()));
    }
  }
}