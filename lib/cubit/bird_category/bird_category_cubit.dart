import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/bird_category_repo.dart';
import '../../utils/get_it.dart';
import 'bird_category_state.dart';

class BirdCategoryCubit extends Cubit<BirdCategoryState>{
  final BirdCategoryRepo _birdCategoryRepo = getIt<BirdCategoryRepo>();

  BirdCategoryCubit() : super(BirdCategoryState());

  Future<void> getBirdCategories({String? name, int? pageNumber, int? pageSize}) async {
    emit(BirdCategoriesLoadingState());
    try {
      var birdCategories = await _birdCategoryRepo.getBirdCategories(name: name, pageNumber: pageNumber, pageSize: pageSize);
      emit(BirdCategoriesSuccessState(birdCategories: birdCategories));
    } catch (e) {
      emit(BirdCategoriesFailedState(e.toString()));
    }
  }
}