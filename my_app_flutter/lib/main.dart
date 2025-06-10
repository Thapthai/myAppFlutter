import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/navbarLayout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/auth/loginPage.dart';
import 'pages/home/homePage.dart';
import 'package:my_app_flutter/pages/profile/profilePage.dart';
import 'package:my_app_flutter/pages/reports/reportsPage.dart';
import 'package:my_app_flutter/pages/setting/settingPage.dart';
import 'package:my_app_flutter/pages/product/productPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Something went wrong จ้า')),
            );
          }

          return snapshot.data == true ? NavbarLayout() : const LoginPage();
        },
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/products': (context) => ProductPage(),
        '/reports': (context) => ReportsPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
