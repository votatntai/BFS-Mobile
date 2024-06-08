import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/cubit/food/food_cubit.dart';
import 'package:flutter_application_1/cubit/food/food_state.dart';
import 'package:flutter_application_1/cubit/food_report/food_report_cubit.dart';
import 'package:flutter_application_1/cubit/food_report/food_report_state.dart';
import 'package:flutter_application_1/domain/models/food_reports.dart';
import 'package:flutter_application_1/domain/repositories/user_repo.dart';
import 'package:flutter_application_1/utils/app_assets.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

class FoodFragment extends StatefulWidget {
  const FoodFragment({super.key});

  @override
  State<FoodFragment> createState() => _FoodFragmentState();
}

class _FoodFragmentState extends State<FoodFragment> {
  TextEditingController planQuantityController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController quantityWillUpdateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<FoodReport> foodReports = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FoodCubit>(
            create: (context) => FoodCubit(),
          ),
          BlocProvider<FoodReportCubit>(create: (context) => FoodReportCubit()..getFoodReports(staffId: UserRepo.user.id!, pageSize: 1000)),
        ],
        child: BlocListener<FoodReportCubit, FoodReportState>(
          listener: (context, state) {
            if (state is FoodReportSuccessState) {
              context.read<FoodCubit>().getFoods(farmId: UserRepo.user.farm!.id!, status: 'Available', pageSize: 1000);
              setState(() {
                foodReports = state.foodReports.foodReports!;
              });
            } 
          },
          child: BlocBuilder<FoodCubit, FoodState>(builder: (context, state) {
            if (state is FoodLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FoodSuccessState) {
              var foods = state.foods;
              return foods.isNotEmpty ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: RefreshIndicator(
                  onRefresh: () {
                    
                    return context.read<FoodReportCubit>().getFoodReports(staffId: UserRepo.user.id!, pageSize: 1000);
                  },
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        shrinkWrap: true,
                        itemCount: foods.length,
                        separatorBuilder: (context, index) => Gap.k8.height,
                        itemBuilder: (context, index) {
                          var isReported = foodReports.any((element) => element.food!.id == foods[index].food!.id);
                          return Container(
                            padding: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                                    child: FadeInImage.assetNetwork(placeholder: AppAssets.placeholder, image: foods[index].food!.thumbnailUrl!, width: 70, height: 70, fit: BoxFit.cover)),
                                Gap.k8.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      foods[index].food!.name!,
                                      style: boldTextStyle(),
                                    ),
                                    Gap.k4.height,
                                    Row(
                                      children: [
                                        foods[index].food!.foodCategory != null
                                            ? SizedBox(
                                                width: 70,
                                                child: Text(
                                                  foods[index].food!.foodCategory!.name!,
                                                  style: secondaryTextStyle(),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        Text(
                                          'Quantity: ',
                                          style: secondaryTextStyle(),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: black, width: 1),
                                            color: gray.withOpacity(0.1),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          child: Text(
                                            foods[index].food!.quantity.toString(),
                                            style: primaryTextStyle(),
                                          ),
                                        ).onTap(() {
                                          var food_cubit = BlocProvider.of<FoodCubit>(context);
                                          var food_report_cubit = BlocProvider.of<FoodReportCubit>(context);
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [BlocProvider.value(
                                                    value: food_cubit,),
                                                    BlocProvider.value(
                                                      value: food_report_cubit)],
                                                    child: BlocConsumer<FoodCubit, FoodState>(listener: (context, state) {
                                                      if (state is CreateFoodReportSuccessState) {
                                                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated')));
                                                        Fluttertoast.showToast(msg: 'Updated');
                                                        Navigator.pop(context);
                                                        context.read<FoodReportCubit>().getFoodReports(staffId: UserRepo.user.id!, pageSize: 1000);
                                                        // context.read<FoodCubit>().getFoods(status: 'Available', pageSize: 1000);
                                                        // setState(() {});
                                                      }
                                                      if (state is CreateFoodReportFailedState) {
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                          content: Text(state.msg.replaceAll('Exception: ', '')),
                                                          backgroundColor: tomato,
                                                        ));
                                                      }
                                                    }, builder: (context, state) {
                                                      return AlertDialog(
                                                        title: const Text('Food report'),
                                                        content: SingleChildScrollView(
                                                          physics: const AlwaysScrollableScrollPhysics(),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                foods[index].food!.name!,
                                                                style: boldTextStyle(size: 20),
                                                              ),
                                                              Gap.k8.height,
                                                              TextField(
                                                                readOnly: true,
                                                                controller: quantityController = TextEditingController(text: foods[index].food!.quantity.toString()),
                                                                keyboardType: TextInputType.number,
                                                                decoration: const InputDecoration(
                                                                  labelText: 'Quantity',
                                                                  border: OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              Gap.k8.height,
                                                              TextField(
                                                                readOnly: true,
                                                                controller: planQuantityController = TextEditingController(text: foods[index].planQuantity.toString()),
                                                                keyboardType: TextInputType.number,
                                                                decoration: const InputDecoration(
                                                                  labelText: 'Plan Quantity',
                                                                  border: OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              Gap.k8.height,
                                                              TextField(
                                                                controller: quantityWillUpdateController =
                                                                    TextEditingController(text: (foods[index].food!.quantity! - foods[index].planQuantity!).toString()),
                                                                keyboardType: TextInputType.number,
                                                                decoration: const InputDecoration(
                                                                  labelText: 'Quantity will update',
                                                                  border: OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              Gap.k8.height,
                                                              TextField(
                                                                controller: descriptionController,
                                                                keyboardType: TextInputType.text,
                                                                maxLines: 3,
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                                  alignLabelWithHint: true,
                                                                  labelText: 'Description',
                                                                  border: OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              Gap.k8.height,
                                                              Text("Note: Minimum 'Quantity to update' is greater than 0 and less than or equal to Quantity - Plan Quantity", style: secondaryTextStyle()),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                            decoration: BoxDecoration(
                                                              color: primaryColor,
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Text(
                                                              'Save',
                                                              style: boldTextStyle(color: white),
                                                            ),
                                                          ).onTap(() {
                                                            // context.read<FoodCubit>().updateFood(id: foods[index].food!.id!, quantity: quantityController.text.toDouble());
                                                            if (quantityWillUpdateController.text.toDouble() > 0 &&
                                                                quantityWillUpdateController.text.toDouble() <= foods[index].food!.quantity! - foods[index].planQuantity!) {
                                                              context.read<FoodCubit>().createFoodReport(
                                                                  staffId: UserRepo.user.id!,
                                                                  foodId: foods[index].food!.id!,
                                                                  lastQuantity: foods[index].food!.quantity!,
                                                                  remainQuantity: quantityWillUpdateController.text.toDouble(),
                                                                  description: descriptionController.text);
                                                            }
                                                          }),
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                            decoration: BoxDecoration(
                                                              color: white,
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Text(
                                                              'Cancel',
                                                              style: boldTextStyle(color: primaryColor),
                                                            ),
                                                          ).onTap(() {
                                                            Navigator.pop(context);
                                                          }),
                                                        ],
                                                      );
                                                    }),
                                                  );
                                                
                                              });
                                        }),
                                        Gap.k4.width,
                                        foods[index].food!.unitOfMeasurement != null
                                            ? Text(
                                                foods[index].food!.unitOfMeasurement!.name!,
                                                style: secondaryTextStyle(),
                                              )
                                            : const SizedBox.shrink(),
                                        const Spacer(),
                                        isReported
                                            ? Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                                                child: const Text(
                                                  'Reported',
                                                  style: TextStyle(color: white),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ],
                                ).expand(),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ) : const Center(child: Text('No food available'));
            }
            if (state is FoodFailedState) {
              return Center(
                child: Text(
                  "Please try again later",
                  style: boldTextStyle(),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
