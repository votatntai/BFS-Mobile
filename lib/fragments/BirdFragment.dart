import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BirdComponent.dart';
import '../cubit/bird/bird_cubit.dart';
import '../cubit/bird/bird_state.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';

class BirdFragment extends StatefulWidget {
  @override
  State<BirdFragment> createState() => _BirdFragmentState();
}

class _BirdFragmentState extends State<BirdFragment> {
  PageController _pageController = PageController();
  bool isCategoryChosen = false;
  bool isGrid = false;
  List<String> categories = ['All', 'Category 1', 'Category 2', 'Category 3'];
  List<String> species = ['All', 'Species 1', 'Species 2', 'Species 3'];
  String? selectedCategory;
  String? selectedSpeies;

  @override
  void initState() {
    super.initState();
    selectedCategory = null;
    selectedSpeies = null;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(children: [
              const Text(
                'Search Bird',
                style: TextStyle(color: gray),
              ),
              const Spacer(),
              SvgPicture.asset(
                AppAssets.magnifying_glass_svg,
                color: primaryColor,
                width: 20,
              ),
            ]),
          ),
          Gap.k16.height,
          Expanded(
              child: Column(
            children: <Widget>[
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor.withOpacity(0.1)),
                    child: Row(
                      children: [
                        selectedCategory != null
                            ? Row(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.xmark_svg,
                                    color: primaryColor,
                                    width: 14,
                                  ).onTap(() {
                                    setState(() {
                                      selectedCategory = null;
                                      selectedSpeies = null;
                                    });
                                  }),
                                  Gap.k8.width,
                                ],
                              )
                            : const SizedBox.shrink(),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: SvgPicture.asset(
                              AppAssets.angle_down_svg,
                              color: primaryColor,
                              width: 14,
                            ),
                            items: categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(color: primaryColor)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                            value: selectedCategory,
                            hint: const Text(
                              'Bird Category',
                              style: TextStyle(color: gray),
                            ),
                          ),
                        ).expand(),
                      ],
                    ),
                  )),
                  Gap.k16.width,
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selectedCategory != null ? primaryColor.withOpacity(0.1) : gray.withOpacity(0.1)),
                    child: Row(
                      children: [
                        selectedSpeies != null
                            ? Row(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.xmark_svg,
                                    color: primaryColor,
                                    width: 14,
                                  ).onTap(() {
                                    setState(() {
                                      selectedSpeies = null;
                                    });
                                  }),
                                  Gap.k8.width,
                                ],
                              )
                            : const SizedBox.shrink(),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: SvgPicture.asset(
                              AppAssets.angle_down_svg,
                              color: selectedCategory != null ? primaryColor : gray,
                              width: 14,
                            ),
                            items: species
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(color: primaryColor)),
                              );
                            }).toList(),
                            onChanged: selectedCategory == null ? null : (newValue) {
                              setState(() {
                                selectedSpeies = newValue;
                              });
                            },
                            value: selectedSpeies,
                            hint: const Text(
                              'Species',
                              style: TextStyle(color: gray),
                            ),
                          ),
                        ).expand(),
                      ],
                    ),
                  )),
                ],
              ),
              Gap.k16.height,
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 80,
                  child: Stack(
                    children: isGrid
                        ? [
                            Positioned(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 8, top: 8, bottom: 8),
                                width: 50,
                                decoration: BoxDecoration(
                                  color: isGrid
                                      ? primaryColor.withOpacity(0.1)
                                      : primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.list_svg,
                                  color: isGrid ? primaryColor : white,
                                  width: 14,
                                  height: 16,
                                ),
                              ).onTap(() {
                                setState(() {
                                  isGrid = false;
                                });
                              }),
                            ),
                            Positioned(
                                left: 30,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: isGrid ? primaryColor : white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.gird_vertical_svg,
                                    color: isGrid ? white : primaryColor,
                                    width: 16,
                                    height: 16,
                                  ),
                                ).onTap(
                                  () {
                                    setState(() {
                                      isGrid = true;
                                    });
                                  },
                                )),
                          ]
                        : [
                            Positioned(
                                left: 30,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 0, top: 8, bottom: 8),
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: isGrid
                                        ? primaryColor
                                        : primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.gird_vertical_svg,
                                    color: isGrid ? white : primaryColor,
                                    width: 16,
                                    height: 16,
                                  ),
                                ).onTap(
                                  () {
                                    setState(() {
                                      isGrid = true;
                                    });
                                  },
                                )),
                            Positioned(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: 50,
                                decoration: BoxDecoration(
                                  color: isGrid ? white : primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.list_svg,
                                  color: isGrid ? primaryColor : white,
                                  width: 16,
                                  height: 16,
                                ),
                              ).onTap(() {
                                setState(() {
                                  isGrid = false;
                                });
                              }),
                            ),
                          ],
                  ),
                ),
              ),
              Gap.k16.height,
              BlocProvider<BirdCubit>(
                create: (context) => BirdCubit()..getBirds(),
                child: BlocBuilder<BirdCubit, BirdState>(
                  builder: (context, state) {
                    if (state is BirdLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                      
                    }
                    if (state is BirdSuccessState) {
                      var birds = state.birds;
                      if (birds.birds!.isEmpty) {
                        // return const Center(child: Text('No bird data available'),);
                        return TextButton(onPressed: (){
                          Navigator.pushNamed(context, '/bird-detail');
                        }, child: Text('Bird detail'));
                      }
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: isGrid
                                ? GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 16,
                                            crossAxisSpacing: 16,
                                            childAspectRatio: 0.72),
                                    itemBuilder: (context, index) {
                                      return BirdComponent(isGrid: isGrid, bird: birds.birds![index],);
                                    })
                                : ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        BirdComponent(
                                          isGrid: isGrid,
                                          bird: birds.birds![index],
                                        ),
                                    separatorBuilder: (context, indext) =>
                                        Gap.k16.height,
                                    itemCount: birds.birds!.length,),
                          ),
                        ],
                      ),
                    );
                    }
                    return const SizedBox.shrink();
                  }
                ),
              )
            ],
          ))
        ],
      ).paddingOnly(left: 16, right: 16, top: 16),
    ));
  }
}
