import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/cage/cage_cubit.dart';
import 'package:flutter_application_1/cubit/cage/cage_state.dart';
import 'package:flutter_application_1/cubit/meal_plan/meal_plan_cubit.dart';
import 'package:flutter_application_1/domain/models/cages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MealPlanComponent.dart';
import '../cubit/meal_plan/meal_plan_state.dart';
import '../screens/MealPlanDetailScreen.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';

class MealPlanFragment extends StatefulWidget {
  const MealPlanFragment({super.key});

  @override
  State<MealPlanFragment> createState() => _MealPlanFragmentState();
}

class _MealPlanFragmentState extends State<MealPlanFragment> {
  Cage? selectedCage;
  DateTime? selectedDate;
  ScrollController scrollController = ScrollController();

  bool isCurrentTimeInRange(String startTime, String endTime) {
    DateTime currentTime = DateTime.now();

    // Tạo đối tượng Time từ startTime và endTime
    List<String> startParts = startTime.split(':');
    List<String> endParts = endTime.split(':');

    int startHour = int.parse(startParts[0]);
    int startMinute = int.parse(startParts[1]);

    int endHour = int.parse(endParts[0]);
    int endMinute = int.parse(endParts[1]);

    TimeOfDay startTimeOfDay = TimeOfDay(hour: startHour, minute: startMinute);
    TimeOfDay endTimeOfDay = TimeOfDay(hour: endHour, minute: endMinute);

    // Chuyển đổi TimeOfDay thành DateTime
    DateTime startTimeConverted = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      startTimeOfDay.hour,
      startTimeOfDay.minute,
    );
    DateTime endTimeConverted = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      endTimeOfDay.hour,
      endTimeOfDay.minute,
    );

    // Kiểm tra xem thời gian hiện tại có nằm trong khoảng thời gian được chỉ định hay không
    if (currentTime.isAfter(startTimeConverted) && currentTime.isBefore(endTimeConverted)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<MealPlanCubit>(
        create: (context) => MealPlanCubit(),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: primaryColor.withOpacity(0.1)),
                    child: Center(
                      child: Text(
                        selectedDate != null ? DateFormat('dd/MM/yyyy').format(selectedDate!) : 'Date',
                        style: boldTextStyle(color: gray, weight: FontWeight.w500),
                      ),
                    ),
                  ).onTap(() {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        setState(() {
                          this.selectedDate = selectedDate;
                        });
                        context.read<MealPlanCubit>().getMealPlans(from: selectedDate, cageId: selectedCage!.id, pageSize: 1000);
                      }
                    });
                  }),
                ),
                Gap.k16.width,
                Expanded(
                    child: BlocProvider<CageCubit>(
                  create: (context) => CageCubit()..getCages(pageSize: 100),
                  child: BlocConsumer<CageCubit, CageState>(listener: (context, state) {
                    if (state is CagesSuccessState) {
                      setState(() {
                        selectedCage = state.cages.cages!.first;
                        context.read<MealPlanCubit>().getMealPlans(cageId: selectedCage!.id, pageSize: 1000);
                      });
                    }
                  }, builder: (context, state) {
                    if (state is CagesSuccessState) {
                      var cages = state.cages.cages;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: primaryColor.withOpacity(0.1)),
                        child: Row(
                          children: [
                            selectedCage != null
                                ? Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.xmark_svg,
                                        color: primaryColor,
                                        width: 14,
                                      ).onTap(() {
                                        setState(() {
                                          selectedCage = null;
                                        });
                                        context.read<MealPlanCubit>().getMealPlans(from: selectedDate, pageSize: 1000);
                                      }),
                                      Gap.k8.width,
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<Cage>(
                                icon: SvgPicture.asset(
                                  AppAssets.angle_down_svg,
                                  color: primaryColor,
                                  width: 14,
                                ),
                                items: cages!.map<DropdownMenuItem<Cage>>((Cage value) {
                                  return DropdownMenuItem<Cage>(
                                    value: value,
                                    child: Text(value.name.toString(), style: const TextStyle(color: primaryColor)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCage = newValue;
                                  });
                                  context.read<MealPlanCubit>().getMealPlans(from: selectedDate, cageId: selectedCage!.id, pageSize: 1000);
                                },
                                value: selectedCage,
                                hint: const Text(
                                  'Cage',
                                  style: TextStyle(color: gray),
                                ),
                              ),
                            ).expand(),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                )),
              ],
            ).paddingRight(16),
            Gap.k16.height,
            Expanded(
              child: BlocBuilder<MealPlanCubit, MealPlanState>(builder: (context, state) {
                if (state is MealPlansLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealPlansSuccessState) {
                  var mealPlans = state.mealPlans;

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<MealPlanCubit>().getMealPlans(from: selectedDate, cageId: selectedCage!.id, pageSize: 1000);
                    },
                    child: Scrollbar(
                      controller: scrollController,
                      child: ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.only(right: 16),
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: mealPlans.mealPlans!.length,
                        separatorBuilder: (context, index) => Gap.k16.height,
                        itemBuilder: (context, index) {
                          var mealPlan = mealPlans.mealPlans![index];
                          List<String> thumbnailUrls = [];
                          for (var meal in mealPlan.menu!.menuMeals!) {
                            if (isCurrentTimeInRange(meal.from!, meal.to!)) {
                              for (var mealItem in meal.mealItems!) {
                                thumbnailUrls.add(mealItem.food!.thumbnailUrl!);
                              }
                            }
                          }

                          return MealPlanComponent(mealPlan: mealPlan, thumbnailUrls: thumbnailUrls).onTap(() {
                            Navigator.pushNamed(context, MealPlanDetailScreen.routeName, arguments: mealPlan.id);
                          });
                        },
                      ),
                    ),
                  );
                } else if (state is MealPlansFailedState) {
                  return Center(
                    child: Text(
                      state.message,
                      style: boldTextStyle(color: gray, weight: FontWeight.w500),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ),
          ],
        ).paddingOnly(bottom: 16, left: 16, right: 0),
      ),
    );
  }
}
