import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/cage_repo.dart';
import '../../utils/get_it.dart';
import 'cage_state.dart';

class CageCubit extends Cubit<CageState> {
  final CageRepo _cageRepo = getIt<CageRepo>();
  CageCubit() : super(CageState());
  Future<void> getCages({String? code, int? pageNumber, int? pageSize}) async {
    emit(CagesLoadingState());
    try {
      var cages = await _cageRepo.getCages(code: code, pageNumber: pageNumber, pageSize: pageSize);
      emit(CagesSuccessState(cages));
    } catch (e) {
      emit(CagesFailedState(e.toString()));
    }
  }

  Future<void> getCageDetail(String id) async {
    emit(CageDetailLoadingState());
    try {
      var cage = await _cageRepo.getCageDetail(id);
      emit(CageDetailSuccessState(cage));
    } catch (e) {
      emit(CageDetailFailedState(e.toString()));
    }
  }
}
