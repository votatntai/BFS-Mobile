import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/meal_plan_repo.dart';
import '../../utils/get_it.dart';
import 'meal_plan_state.dart';

class MealPlanCubit extends Cubit<MealPlanState>{
  final MealPlanRepo _mealPlanRepo = getIt<MealPlanRepo>();

  MealPlanCubit() : super(MealPlanState());

  Future<void> getMealPlans({DateTime? from, DateTime? to, String? menuId, String? cageId, int? pageNumber, int? pageSize}) async {
    emit(MealPlansLoadingState());
    try {
      var mealPlans = await _mealPlanRepo.getMealPlans(from: from, to: to, menuId: menuId, cageId: cageId, pageNumber: pageNumber, pageSize: pageSize);
      emit(MealPlansSuccessState(mealPlans));
    } catch (e) {
      emit(MealPlansFailedState(e.toString()));
    }
  }

  Future<void> getMealPlan({required String id}) async {
    emit(MealPlanLoadingState());
    try {
      var mealPlan = await _mealPlanRepo.getMealPlan(id: id);
      emit(MealPlanSuccessState(mealPlan));
    } catch (e) {
      emit(MealPlanFailedState(e.toString()));
    }
  }
}