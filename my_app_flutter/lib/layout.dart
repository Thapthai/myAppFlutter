import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/logout.dart';
import 'package:my_app_flutter/pages/home/homePage.dart';
import 'package:my_app_flutter/pages/product/productPage.dart';
import 'package:my_app_flutter/pages/reports/reportsPage.dart';
import 'package:my_app_flutter/pages/profile/profilePage.dart';
import 'package:my_app_flutter/pages/setting/settingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  String userName = 'Loading...'; // ตัวแปรเก็บชื่อผู้ใช้
  String userEmail = 'Loading...'; // ตัวแปรเก็บชื่อผู้ใช้

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? 'ชื่อผู้ใช้';
    final email = prefs.getString('email') ?? 'email';
    setState(() {
      userName = name;
      userEmail = email;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages = [
    HomePage(onMenuTap: _onItemTapped), // หน้า 0
    ProductPage(), // หน้า 1
    ReportsPage(), // หน้า 2
    ProfilePage(), // หน้า 3
    SettingsPage(), // หน้า 4
  ];

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      appBar: AppBar(
        title: const Text('เมนูหลัก'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: const [LogoutButton()],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(userName, style: const TextStyle(color: Colors.white)),
                  Text(
                    userEmail,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('โปรไฟล์'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 3; // เปลี่ยนไปหน้าโปรไฟล์ (index 3)
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('ออกจากระบบ'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'สินค้า',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'รายงาน'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'โปรไฟล์'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'ตั้งค่า'),
        ],
      ),
    );
  }
}
