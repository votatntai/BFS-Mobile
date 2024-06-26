// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/meal_plan/meal_plan_cubit.dart';
import 'package:flutter_application_1/cubit/meal_plan/meal_plan_state.dart';
import 'package:flutter_application_1/domain/repositories/meal_plan_repo.dart';
import 'package:flutter_application_1/utils/app_assets.dart';
import 'package:flutter_application_1/utils/format.dart';
import 'package:flutter_application_1/utils/gap.dart';
import 'package:flutter_application_1/widgets/AppBar.dart';
import 'package:flutter_application_1/widgets/Background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class MealPlanDetailScreen extends StatefulWidget {
  const MealPlanDetailScreen({super.key, required this.mealPlanId});
  static const String routeName = '/meal-plan-detail';
  final String mealPlanId;

  @override
  State<MealPlanDetailScreen> createState() => _MealPlanDetailScreenState();
}

class _MealPlanDetailScreenState extends State<MealPlanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Meal Plan Detail',
        ),
        body: Background(
            child: BlocProvider<MealPlanCubit>(
          create: (context) => MealPlanCubit()..getMealPlan(id: widget.mealPlanId),
          child: BlocBuilder<MealPlanCubit, MealPlanState>(builder: (context, state) {
            if (state is MealPlanLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MealPlanSuccessState) {
              var mealPlan = state.mealPlan;
              mealPlan.menu!.menuMeals!.sort((a, b) => a.from!.compareTo(b.from!));
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Menu',
                            style: secondaryTextStyle(size: 14),
                          ),
                          Text(
                            mealPlan.menu!.name!,
                            style: boldTextStyle(size: 16),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        AppAssets.list_check_svg,
                        width: 24,
                        height: 24,
                        color: gray,
                      ).onTap(() {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            var planDetails = mealPlan.planDetails!;
                            planDetails.sort((a, b) => a.date!.compareTo(b.date!));
                            return StatefulBuilder(builder: (context, StateSetter setState) {
                              return SizedBox(
                                height: context.height() * 0.8,
                                child: Column(
                                  children: [
                                    Expanded(
                                      // Sử dụng Expanded để ListView chiếm hết không gian còn lại
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            title: Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(planDetails[index].date!)).toString()),
                                            value: planDetails[index].status,
                                            onChanged: (value) {
                                              setState(() {
                                                planDetails[index].status = value!;
                                              });
                                              MealPlanRepo().updatePlanDetailStatus(planDetailId: planDetails[index].id!, status: value!);
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) => Gap.k8.height,
                                        itemCount: planDetails.length,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      }),
                    ],
                  ),
                  Gap.k16.height,
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          var menuMeal = mealPlan.menu!.menuMeals![index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(menuMeal.name!, style: boldTextStyle(size: 14)),
                                    const Spacer(),
                                    Text("${myFormatTime(menuMeal.from!)} - ${myFormatTime(menuMeal.to!)}", style: secondaryTextStyle(size: 14)),
                                  ],
                                ),
                                Gap.k8.height,
                                menuMeal.mealItems!.isNotEmpty
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: menuMeal.mealItems!.length,
                                        separatorBuilder: (context, index) => Gap.k8.height,
                                        itemBuilder: (context, index) {
                                          menuMeal.mealItems!.sort((a, b) => a.order!.compareTo(b.order!));
                                          var food = menuMeal.mealItems![index].food!;
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${food.name!} - ", style: primaryTextStyle(size: 16)),
                                              Text('${menuMeal.mealItems![index].quantity} ${food.unitOfMeasurement!.name!}', style: secondaryTextStyle(size: 16)),
                                              const Spacer(),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: FadeInImage.assetNetwork(placeholder: AppAssets.food_placeholder, image: food.thumbnailUrl!, width: 35, height: 35, fit: BoxFit.cover),
                                              )
                                            ],
                                          );
                                        })
                                    : Text(
                                        "No meal items found",
                                        style: secondaryTextStyle(),
                                      ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Gap.k16.height,
                        itemCount: mealPlan.menu!.menuMeals!.length),
                  )
                ],
              ).paddingSymmetric(horizontal: 16);
            }
            return const SizedBox.shrink();
          }),
        )));
  }
}
