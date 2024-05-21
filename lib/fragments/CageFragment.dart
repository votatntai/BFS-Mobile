import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/cage/cage_cubit.dart';
import 'package:flutter_application_1/cubit/cage/cage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/CageComponent.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';

class CageFragment extends StatefulWidget {
  @override
  State<CageFragment> createState() => _CageFragmentState();
}

class _CageFragmentState extends State<CageFragment> {
  PageController _pageController = PageController();
  bool isCategoryChosen = false;
  bool isGrid = false;
  List<String> careMode = ['All', 'Mode 1', 'Mode 2', 'Mode 3'];
  List<String> species = ['All', 'Species 1', 'Species 2', 'Species 3'];
  String? selectedCareMode;
  String? selectedSpeies;

  @override
  void initState() {
    super.initState();
    selectedCareMode = null;
    selectedSpeies = null;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                'Search cage',
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: primaryColor.withOpacity(0.1)),
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
                            items: species.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(color: primaryColor)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
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
                  Gap.k16.width,
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: selectedSpeies != null ? primaryColor.withOpacity(0.1) : gray.withOpacity(0.1)),
                    child: Row(
                      children: [
                        selectedCareMode != null
                            ? Row(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.xmark_svg,
                                    color: primaryColor,
                                    width: 14,
                                  ).onTap(() {
                                    setState(() {
                                      selectedCareMode = null;
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
                              color: selectedSpeies != null ? primaryColor : gray,
                              width: 14,
                            ),
                            items: careMode.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(color: primaryColor)),
                              );
                            }).toList(),
                            onChanged: selectedSpeies == null
                                ? null
                                : (newValue) {
                                    setState(() {
                                      selectedCareMode = newValue;
                                    });
                                  },
                            value: selectedCareMode,
                            hint: const Text(
                              'Care Mode',
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
                                padding: const EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
                                width: 50,
                                decoration: BoxDecoration(
                                  color: isGrid ? primaryColor.withOpacity(0.1) : primaryColor,
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
                                  padding: const EdgeInsets.only(left: 8, right: 0, top: 8, bottom: 8),
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: isGrid ? primaryColor : primaryColor.withOpacity(0.1),
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
              BlocProvider<CageCubit>(
                create: (context) => CageCubit()..getCages(),
                child: BlocBuilder<CageCubit, CageState>(builder: (context, state) {
                  if (state is CagesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CagesSuccessState) {
                    var cages = state.cages;
                    if (cages.cages!.isEmpty) {
                      // return const Center(child: Text('No bird data available'),);
                      return const Center(child: Text('No cage'));
                    }
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: isGrid
                                ? GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.72),
                                    itemBuilder: (context, index) {
                                      return CageComponent(
                                        isGrid: isGrid,
                                        cage: cages.cages![index],
                                      );
                                    })
                                : ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) => CageComponent(
                                      isGrid: isGrid,
                                      cage: cages.cages![index],
                                    ),
                                    separatorBuilder: (context, indext) => Gap.k16.height,
                                    itemCount: cages.cages!.length,
                                  ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              )
            ],
          ))
        ],
      ).paddingOnly(left: 16, right: 16, bottom: 16),
    ));
  }
}
