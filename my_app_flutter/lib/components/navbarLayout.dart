import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/logout.dart';
import 'package:my_app_flutter/pages/home/homePage.dart';
import 'package:my_app_flutter/pages/product/productPage.dart';
import 'package:my_app_flutter/pages/reports/reportsPage.dart';
import 'package:my_app_flutter/pages/profile/profilePage.dart';
import 'package:my_app_flutter/pages/setting/settingPage.dart';

class NavbarLayout extends StatefulWidget {
  const NavbarLayout({super.key});

  @override
  State<NavbarLayout> createState() => _NavbarLayoutState();
}

class _NavbarLayoutState extends State<NavbarLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ProductPage(),
    ReportsPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  final List<String> _titles = [
    "Home",
    "Products",
    "Reports",
    "Profile",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: const [
          LogoutButton(), // ✅ ใส่ปุ่ม logout ที่นี่แทน
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reports",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
