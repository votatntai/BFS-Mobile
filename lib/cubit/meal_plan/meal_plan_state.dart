import '../../domain/models/mealplans.dart';

class MealPlanState {}

class MealPlansLoadingState extends MealPlanState {}

class MealPlansSuccessState extends MealPlanState {
  final MealPlans mealPlans;
  MealPlansSuccessState(this.mealPlans);
}

class MealPlansFailedState extends MealPlanState {
  final String message;
  MealPlansFailedState(this.message);
}

class MealPlanLoadingState extends MealPlanState {}

class MealPlanSuccessState extends MealPlanState {
  final MealPlan mealPlan;
  MealPlanSuccessState(this.mealPlan);
}

class MealPlanFailedState extends MealPlanState {
  final String message;
  MealPlanFailedState(this.message);
}