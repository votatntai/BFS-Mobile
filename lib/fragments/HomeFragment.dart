import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/TaskComponent.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

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
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Material(
              color: transparentColor,
              child: Column(
                children: <Widget>[
                  // Custom TabBar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // Custom tab buttons
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedIndex == 0
                                ? primaryColor
                                : primaryColor.withOpacity(0.1)),
                        child: Text(
                          'To do',
                          style: TextStyle(
                              color: _selectedIndex == 0 ? white : primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ).onTap(() => _onItemTapped(0)),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedIndex == 1
                                ? primaryColor
                                : primaryColor.withOpacity(0.1)),
                        child: Text(
                          'In progress',
                          style: TextStyle(
                              color: _selectedIndex == 1 ? white : primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ).onTap(() => _onItemTapped(1)),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedIndex == 2
                                ? primaryColor
                                : primaryColor.withOpacity(0.1)),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              color: _selectedIndex == 2 ? white : primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ).onTap(() => _onItemTapped(2)),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      children: <Widget>[
                        // Nội dung của mỗi "tab"
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      TaskComponent(),
                                  separatorBuilder: (context, indext) =>
                                      Gap.k16.height,
                                  itemCount: 3),
                            )
                          ],
                        ).paddingTop(32),
                        Center(child: Text('Search Tab Content')),
                        Center(child: Text('Notifications Tab Content')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 32),
    );
  }
}
