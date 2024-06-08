import '../../domain/models/food_reports.dart';

class FoodReportState {}

class FoodReportLoadingState extends FoodReportState {}

class FoodReportSuccessState extends FoodReportState {
  final FoodReports foodReports;

  FoodReportSuccessState(this.foodReports);
}

class FoodReportFailedState extends FoodReportState {
  final String message;

  FoodReportFailedState(this.message);
}