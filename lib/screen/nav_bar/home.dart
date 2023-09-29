import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:ingliz_tili/screen/nav_bar/home_page/home_page.dart';
import 'package:ingliz_tili/screen/nav_bar/profile_page/profile_page.dart';
import 'package:ingliz_tili/screen/nav_bar/all_task_page/task_page.dart';
import 'package:ingliz_tili/utils/color.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TaskPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey)],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: AppColors.appBarColor,
          ),
          child: FlashyTabBar(
            backgroundColor: Colors.transparent,
            shadows: const [BoxShadow(color: Colors.transparent)],
            selectedIndex: _selectedIndex,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
            }),
            items: [
              FlashyTabBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.grid_view_outlined),
                title: const Text('Task'),
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.border_all_rounded),
                title: const Text('Barchasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
