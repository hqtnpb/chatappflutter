import 'dart:convert';

import 'package:chatapp/access_token_firebase.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  //email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginPage({super.key});

  //login function
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
      String? token = await FirebaseMessaging.instance.getToken();

      sendNotification(token!, 'Login Successful', 'Login Successful');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  Future<void> sendNotification(String token, title, body1) async {
    AccessTokenFirebase accessTokenGetter = AccessTokenFirebase();
    String accessToken = await accessTokenGetter.getAccessToken();
    const postUrl =
        'https://fcm.googleapis.com/v1/projects/chatappbtl-e2c94/messages:send';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = {
      'message': {
        'notification': {
          'title': title,
          'body': body1,
        },
        'token': token,
      },
    };

    final response = await http.post(
      Uri.parse(postUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
      print(response.body);
    } else {
      print(
          'Failed to send notification: ${response.statusCode} - ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.lightBlue,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                const Icon(
                  Icons.message,
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),

                //welcome back message
                const Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 25),

                //email field
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController,
                  prefixIcon: Icon(Icons.email),
                ),
                const SizedBox(height: 10),

                //pw field
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                  prefixIcon: Icon(Icons.lock),
                ),
                const SizedBox(height: 25),

                //login button
                MyButton(
                  text: "Login",
                  onTap: () => login(context),
                ),
                // MyButton(
                //     text: "Test",
                //     onTap: () async {
                //       AccessTokenFirebase accessTokenGetter =
                //           AccessTokenFirebase();
                //       String token = await accessTokenGetter.getAccessToken();
                //       print('ABC' + token);
                //     }),
                const SizedBox(height: 25),

                //forgot password

                //register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?",
                        style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text(" Register now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
