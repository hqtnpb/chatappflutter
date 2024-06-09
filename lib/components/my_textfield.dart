import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Icon prefixIcon;
  const MyTextField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.prefixIcon, // And this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon, // And this line

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    20.0), // This line adds the border radius

                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    20.0), // This line adds the border radius

                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          )),
    );
  }
}
