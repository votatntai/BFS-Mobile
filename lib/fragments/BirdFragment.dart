import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BirdComponent.dart';
import '../components/TaskComponent.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';
import '../widgets/Tab.dart';

class BirdFragment extends StatefulWidget {
  @override
  State<BirdFragment> createState() => _BirdFragmentState();
}

class _BirdFragmentState extends State<BirdFragment> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  bool isGrid = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(children: [
              Text(
                'Search Bird',
                style: TextStyle(color: gray),
              ),
              Spacer(),
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
                      child: CustomTab(
                              selectedIndex: _selectedIndex,
                              title: 'Bird category',
                              index: 0)
                          .onTap(() => _onItemTapped(0))),
                  Gap.k16.width,
                  Expanded(
                      child: CustomTab(
                              selectedIndex: _selectedIndex,
                              title: 'Species',
                              index: 1)
                          .onTap(() => _onItemTapped(1))),
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
                                padding: EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
                                width: 50,
                                decoration: BoxDecoration(
                                  color: isGrid ? primaryColor.withOpacity(0.1) : primaryColor,
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
                            Positioned(
                                left: 30,
                                child: Container(
                                  padding: EdgeInsets.all(8),
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
                                  padding: EdgeInsets.only(left: 8, right: 0, top: 8, bottom: 8),
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
                                padding: EdgeInsets.all(8),
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
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: isGrid ? GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.72), itemBuilder: (context, index){
                           return BirdComponent(isGrid: isGrid); 
                          }) : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  BirdComponent(isGrid: isGrid,),
                              separatorBuilder: (context, indext) =>
                                  Gap.k16.height,
                              itemCount: 5),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ).paddingOnly(left: 16, right: 16, top: 16),
    ));
  }
}
