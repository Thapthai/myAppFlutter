import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OTPPage extends StatefulWidget {
  final String twofaToken;
  final int userId;

  const OTPPage({super.key, required this.twofaToken, required this.userId});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final otpController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> verifyOTP() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final twofaToken = args['twofa_token'];
    int userId = args['user_id'];

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.100:3000/auth/2fa/login'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $twofaToken',
        },
        body: jsonEncode({'userId': userId, 'code': otpController.text}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 &&
          data['status'] == 'LOGIN_2FA_SUCCESSFUL') {
        final user = data['user'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', user['access_token']);
        await prefs.setString('name', user['name']);
        await prefs.setString('email', user['email']);
        await prefs.setInt('id', user['id']);
        await prefs.setInt('permission', user['permission']);

        Navigator.pushReplacementNamed(context, '/main');
      } else {
        setState(() {
          errorMessage = data['message'] ?? 'OTP verification failed';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Connection error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(labelText: "OTP Code"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: verifyOTP,
                    child: const Text("Verify"),
                  ),
          ],
        ),
      ),
    );
  }
}
