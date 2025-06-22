
// lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_service.dart';
import '../screens/home_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  final storage = FlutterSecureStorage();

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password cannot be empty",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    final response = await ApiService.login(email, password);
    isLoading.value = false;

    if (response['error'] != null) {
      Get.snackbar("Login Failed", response['error'],
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } else {
      await storage.write(key: 'token', value: response['access_token']);
      Get.snackbar("Success", "Login successful",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.off(() => const HomeScreen());
    }
  }
}