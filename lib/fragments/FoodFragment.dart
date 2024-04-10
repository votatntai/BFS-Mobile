import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/cubit/food/food_cubit.dart';
import 'package:flutter_application_1/cubit/food/food_state.dart';
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
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider<FoodCubit>(
      create: (context) => FoodCubit()..getFoods(status: 'Available'),
      child: BlocBuilder<FoodCubit, FoodState>(builder: (context, state) {
        if (state is FoodLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FoodSuccessState) {
          var foods = state.foods.foods!;
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () => context.read<FoodCubit>().getFoods(),
              child: Column(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    shrinkWrap: true,
                    itemCount: foods.length,
                    separatorBuilder: (context, index) => Gap.k8.height,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                                child: FadeInImage.assetNetwork(placeholder: AppAssets.placeholder, image: foods[index].thumbnailUrl!, width: 70, height: 70, fit: BoxFit.cover)),
                            Gap.k8.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  foods[index].name!,
                                  style: boldTextStyle(),
                                ),
                                Gap.k4.height,
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        foods[index].foodCategory!.name!,
                                        style: secondaryTextStyle(),
                                      ),
                                    ),
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
                                        foods[index].quantity.toString(),
                                        style: primaryTextStyle(),
                                      ),
                                    ).onTap(() {
                                      var cubit = BlocProvider.of<FoodCubit>(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return BlocProvider.value(
                                              value: cubit,
                                              child: BlocConsumer<FoodCubit, FoodState>(listener: (context, state) {
                                                if (state is CreateFoodReportSuccessState) {
                                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated')));
                                                  Fluttertoast.showToast(msg: 'Updated');
                                                  Navigator.pop(context);
                                                  context.read<FoodCubit>().getFoods();
                                                  // setState(() {});
                                                }
                                                if (state is CreateFoodReportFailedState) {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg.replaceAll('Exception: ', '')), backgroundColor: tomato,));
                                                }
                                              }, builder: (context, state) {
                                                return AlertDialog(
                                                  title: const Text('Food report'),
                                                  content: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(foods[index].name!, style: boldTextStyle(size: 20),),
                                                      Gap.k16.height,
                                                      TextField(
                                                        controller: quantityController = TextEditingController(text: foods[index].quantity.toString()),
                                                        keyboardType: TextInputType.number,
                                                        decoration: const InputDecoration(
                                                          labelText: 'Quantity',
                                                          border: OutlineInputBorder(),
                                                        ),
                                                      ),
                                                      Gap.k8.height,
                                                      TextField(
                                                        controller: descriptionController,
                                                        keyboardType: TextInputType.text,
                                                        maxLines: 5,
                                                        decoration: const InputDecoration(
                                                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                          alignLabelWithHint: true,
                                                          labelText: 'Description',
                                                          border: OutlineInputBorder(),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                  actions: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: primaryColor,
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: Text(
                                                        'Save', style: boldTextStyle(color: white),
                                                      ),
                                                    ).onTap((){
                                                      // context.read<FoodCubit>().updateFood(id: foods[index].id!, quantity: quantityController.text.toDouble());
                                                      context.read<FoodCubit>().createFoodReport(staffId: UserRepo.user.id!, foodId: foods[index].id!, lastQuantity: foods[index].quantity!, remainQuantity: quantityController.text.toDouble(), description: descriptionController.text);
                                                    }),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: white,
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: Text(
                                                        'Cancel', style: boldTextStyle(color: primaryColor),
                                                      ),
                                                    ).onTap((){
                                                      Navigator.pop(context);
                                                    }),
                                                   
                                                  ],
                                                );
                                              }),
                                            );
                                          });
                                    }),
                                    Gap.k4.width,
                                    Text(
                                      foods[index].unitOfMeasurement!.name!,
                                      style: secondaryTextStyle(),
                                    ),
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
          );
        }
        return const SizedBox.shrink();
      }),
    ));
  }
}
