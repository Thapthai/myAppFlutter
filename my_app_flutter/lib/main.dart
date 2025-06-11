import 'package:flutter/material.dart';
import 'package:my_app_flutter/layout.dart';
import 'package:my_app_flutter/pages/auth/otp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/auth/loginPage.dart';

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

          return snapshot.data == true ? Layout() : const LoginPage();
        },
      ),

      routes: {
        '/login': (context) => const LoginPage(),
        '/otp': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return OTPPage(
            twofaToken: args['twofa_token'],
            userId: args['user_id'],
          );
        },
        '/main': (context) => const Layout(), // ← ตรงนี้สำคัญ
      },
    );
  }
}
