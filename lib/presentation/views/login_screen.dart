import 'package:chat_app/core/services/call_services.dart';
import 'package:chat_app/presentation/views/second_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/const.dart';
import '../../main.dart';
import '../manager/background_color_provider.dart';
import '../widgets/login_button.dart';
import 'first_chat_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<BackgroundColorProvider>(
            builder: (context, backgroundColorProvider, child) {
              return Image.asset(
                backgroundColorProvider.selectedBackground,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'User ID',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: userIdController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ID number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your ID number',
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    LoginButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          sharedPreferences.setString(
                            'userId',
                            userIdController.text,
                          );
                          sharedPreferences.setString(
                            'username',
                            usernameController.text,
                          );
                          CallServices callServices = CallServices();
                          callServices.onUserLogin(
                            userIdController.text,
                            usernameController.text,
                          );
                          if (usernameController.text.toLowerCase() ==
                                  'Maria'.toLowerCase() &&
                              userIdController.text == '654321') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SecondChatScreen(),
                              ),
                            );
                          } else if (usernameController.text.toLowerCase() ==
                                  'Alex'.toLowerCase() &&
                              userIdController.text == '123456') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirstChatScreen(),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
