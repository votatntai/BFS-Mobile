import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Material(
              child: Column(
                children: <Widget>[
                  // Custom TabBar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // Custom tab buttons
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () => _onItemTapped(0),
                        color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => _onItemTapped(1),
                        color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () => _onItemTapped(2),
                        color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                      ),
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
                        Center(child: Text('Home Tab Content')),
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
      ).paddingSymmetric(horizontal: 32),
    );
  }
}
