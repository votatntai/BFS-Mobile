import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/bird_repo.dart';
import '../../utils/get_it.dart';
import 'bird_state.dart';

class BirdCubit extends Cubit<BirdState>{
  final BirdRepo _birdRepo = getIt<BirdRepo>();

  BirdCubit() : super(BirdState());

  Future<void> getBirds({String? name, String? categoryId, int? pageNumber, int? pageSize}) async {
    emit(BirdLoadingState());
    try {
      var birds = await _birdRepo.getBirds(name: name, categoryId: categoryId, pageNumber: pageNumber, pageSize: pageSize);
      emit(BirdSuccessState(birds: birds));
    } catch (e) {
      emit(BirdFailedState(e.toString()));
    }
  }

  Future<void> getBirdDetail(String id) async {
    emit(BirdDetailLoadingState());
    try {
      var bird = await _birdRepo.getBirdDetail(id);
      emit(BirdDetailSuccessState(bird: bird));
    } catch (e) {
      emit(BirdDetailFailedState(e.toString()));
    }
  }
}