import 'package:authtask/core/routing/routes.dart';
import 'package:authtask/core/util/extentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../domain/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/util/color_manager.dart';





class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // RxBool for field error management
  final RxBool isObscureText = false.obs;
  final RxString emailError = "".obs;
  final RxString passwordError = "".obs;
  final RxString isLoginRequsted = "".obs;

  SignInScreen({super.key});

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Loading...."),
          ],
        ),
      ),
    );
  }

  void validateFields() {
    emailError.value = emailController.text.isValidEmail() ? "" : "Invalid email format";
    passwordError.value = passwordController.text.isValidPassword()
        ? ""
        : "Password must be at least 6 characters";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              _showLoadingDialog(context);
            } else {
              Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading dialog
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${state.errorMessage}")),
                );
              } else if (state is LoginSuccess) {
                Navigator.pushReplacementNamed(context, Routes.homeScreen);
              }
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Let's sign you in",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.darkBlue3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Welcome Back,",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.darkBlue3,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "You have been missed!",
                      style: TextStyle(
                        fontSize: 36,
                        color: ColorManager.darkBlue3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Email", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    // Email TextField with validation
                    Obx(
                          () => TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: ' your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorText: emailError.value.isEmpty ? null : emailError.value ,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) => validateFields(),
                      ),
                    ),
                    const SizedBox(height: 20),
                
                    const Text("Password", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    // Password TextField with validation
                    Obx(
                          () => TextField(
                        controller: passwordController,
                        obscureText: isObscureText.value,
                        decoration: InputDecoration(
                          labelText: ' password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorText: passwordError.value.isEmpty ? null : passwordError.value,
                          suffixIcon: IconButton(
                            icon: Icon(isObscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              isObscureText.value = !isObscureText.value;
                            },
                          ),
                        ),
                        onChanged: (_) => validateFields(),
                      ),
                    ),
                    const SizedBox(height: 40),

                    SizedBox(height: 100),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          validateFields();
                          if (emailError.value.isEmpty && passwordError.value.isEmpty) {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            context
                                .read<LoginCubit>()
                                .loginWithEmailAndPassword(email, password);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Register Screen
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.darkBlue3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
