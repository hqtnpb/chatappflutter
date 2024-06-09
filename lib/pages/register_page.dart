import 'dart:io';

import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  //tap to login
  File? _image;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //pick image function
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<String> uploadImage(File image) async {
    final ref = _storage.ref().child('profile_pics/${_image!.path}');

    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  //upload image function

  //register function
  void register(BuildContext context) async {
    //get auth service
    final _auth = AuthService();

    //check if passwords match => create account
    final imageUrl = await uploadImage(_image!);
    if (_passwordController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(_emailController.text,
            _passwordController.text, _nameController.text, imageUrl);
        // Redirect to the HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Invalid credentials'),
            content: Text('The provided email or password is not valid.'),
          ),
        );
      }
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
                // const Icon(
                //   Icons.message,
                //   size: 60,
                //   color: Colors.white,
                // ),
                // const SizedBox(height: 20),

                //welcome back message
                const Text(
                  "Let's create an account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                    onTap: _pickImage,
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: _image == null
                            ? const Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ))),
                const SizedBox(height: 25),
                //name field
                MyTextField(
                  hintText: "Name",
                  obscureText: false,
                  controller: _nameController,
                  prefixIcon: const Icon(Icons.person),
                ),

                const SizedBox(height: 10),
                //email field
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController,
                  prefixIcon: const Icon(Icons.email),
                ),

                const SizedBox(height: 10),
                //pw field
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.lock),
                ),

                const SizedBox(height: 10),
                //confirm password
                MyTextField(
                  hintText: " Confirm Password",
                  obscureText: true,
                  controller: _confirmPwController,
                  prefixIcon: const Icon(Icons.lock),
                ),

                const SizedBox(height: 25),
                //login button
                MyButton(
                  text: "Register",
                  onTap: () => register(context),
                ),

                const SizedBox(height: 25),

                //register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(" Login now",
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
