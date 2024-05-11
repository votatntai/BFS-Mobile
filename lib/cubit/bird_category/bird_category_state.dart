import '../../domain/models/birdcategories.dart';

class BirdCategoryState {}

class BirdCategoriesLoadingState extends BirdCategoryState {}

class BirdCategoriesSuccessState extends BirdCategoryState {
  final BirdCategories birdCategories;
  BirdCategoriesSuccessState({required this.birdCategories});
}

class BirdCategoriesFailedState extends BirdCategoryState {
  final String error;
  BirdCategoriesFailedState(this.error);
}
