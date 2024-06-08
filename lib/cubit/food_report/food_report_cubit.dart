import 'package:flutter_application_1/domain/repositories/food_repo.dart';
import 'package:flutter_application_1/utils/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'food_report_state.dart';

class FoodReportCubit extends Cubit<FoodReportState> {
  final FoodRepo _foodRepo = getIt.get<FoodRepo>();
  FoodReportCubit() : super(FoodReportState());

  Future<void> getFoodReports({required String staffId, int? pageNumber, int? pageSize}) async {
    emit(FoodReportLoadingState());
    try {
      var foods = await _foodRepo.getFoodReport(staffId: staffId, pageNumber: pageNumber, pageSize: pageSize);
      emit(FoodReportSuccessState(foods));
    } catch (e) {
      emit(FoodReportFailedState(e.toString()));
    }
  }
}