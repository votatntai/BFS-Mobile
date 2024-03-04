import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/bird_repo.dart';
import '../../utils/get_it.dart';
import 'bird_state.dart';

class BirdCubit extends Cubit<BirdState>{
  final BirdRepo _birdRepo = getIt<BirdRepo>();

  BirdCubit() : super(BirdState());

  Future<void> getBirds({String? name, int? pageNumber, int? pageSize}) async {
    emit(BirdLoadingState());
    try {
      var birds = await _birdRepo.getBirds(name: name, pageNumber: pageNumber, pageSize: pageSize);
      emit(BirdSuccessState(birds: birds));
    } catch (e) {
      emit(BirdFailedState(e.toString()));
    }
  }
}