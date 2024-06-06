import '../../domain/models/food.dart';
import '../../domain/models/foods.dart';

class FoodState {}

class FoodLoadingState extends FoodState {}

class FoodSuccessState extends FoodState {
  final List<Foodd> foods;
  FoodSuccessState(this.foods);
}

class FoodFailedState extends FoodState {
  final String msg;
  FoodFailedState(this.msg);
}

class UpdateFoodLoadingState extends FoodState {}

class UpdateFoodSuccessState extends FoodState {
  final Food food;
  UpdateFoodSuccessState(this.food);
}

class UpdateFoodFailedState extends FoodState {
  final String msg;
  UpdateFoodFailedState(this.msg);
}

class CreateFoodReportLoadingState extends FoodState {}

class CreateFoodReportSuccessState extends FoodState {}

class CreateFoodReportFailedState extends FoodState {
  final String msg;
  CreateFoodReportFailedState(this.msg);
}
