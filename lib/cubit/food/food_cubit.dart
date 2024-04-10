import 'package:flutter_application_1/domain/repositories/food_repo.dart';
import 'package:flutter_application_1/utils/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'food_state.dart';

class FoodCubit extends Cubit<FoodState>{
  FoodCubit() : super(FoodState());
  final FoodRepo _foodRepo = getIt.get<FoodRepo>();

  Future<void> getFoods({String? name, String? status, int? pageNumber, int? pageSize}) async {
    emit(FoodLoadingState());
    try {
      var foods = await _foodRepo.getFoods(name: name, status: status, pageNumber: pageNumber, pageSize: pageSize);
      emit(FoodSuccessState(foods));
    } catch (e) {
      emit(FoodFailedState(e.toString()));
    }
  }

  Future<void> updateFood({required String id, XFile? thumbnail, String? foodCategoryId, double? quantity, String? unitOfMeasurement, String? status}) async {
    emit(UpdateFoodLoadingState());
    try {
      var food = await _foodRepo.updateFood(id: id, thumbnail: thumbnail, foodCategoryId: foodCategoryId, quantity: quantity, unitOfMeasurement: unitOfMeasurement, status: status);
      emit(UpdateFoodSuccessState(food));
    } catch (e) {
      emit(UpdateFoodFailedState(e.toString()));
    }
  }

  Future<void> createFoodReport({required String staffId, required String foodId, required double lastQuantity, required double remainQuantity, String? description}) async {
    emit(CreateFoodReportLoadingState());
    try {
      await _foodRepo.createFoodReport(staffId: staffId, foodId: foodId, lastQuantity: lastQuantity, remainQuantity: remainQuantity, description: description);
      emit(CreateFoodReportSuccessState());
    } catch (e) {
      emit(CreateFoodReportFailedState(e.toString()));
    }
  }
}