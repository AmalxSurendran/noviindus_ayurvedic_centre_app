import 'dart:developer';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController wanumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController minController = TextEditingController();
  final signformKey = GlobalKey<FormState>();
  final regformKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  String? selectedBranch;
  String? selectedLocation;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  // Email validation
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return '\u26A0 Email is required.';
    }
    if (!_isValidEmail(value)) {
      return '\u26A0 Enter a valid email address.';
    }
    return null;
  }

  // Password validation
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return '\u26A0 Password is required.';
    }
    if (value.length < 6) {
      return '\u26A0 Password must be at least 6 characters.';
    }
    return null;
  }

  // field validation
  String? validatefield(String value) {
    if (value.isEmpty) {
      return '\u26A0 This field is required.';
    }
    if (!_isValidEmail(value)) {
      return '\u26A0 Invalid.';
    }
    return null;
  }

  bool _isValidEmail(String value) {
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    final usernameRegExp = RegExp(r"^[a-zA-Z0-9._-]+$");
    return emailRegExp.hasMatch(value) || usernameRegExp.hasMatch(value);
  }

  // Login logic
  Future<void> login(BuildContext context) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      log('Logging in with email: ${emailController.text} and password: ${passwordController.text}');
      Navigator.pushReplacementNamed(context, '/homepage');
    } else {
      log('Error: Invalid email or password');
    }
  }

  Future<void> register(BuildContext context) async {
    if (nameController.text.isNotEmpty &&
        wanumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        branchController.text.isNotEmpty &&
        balanceController.text.isNotEmpty &&
        totalController.text.isNotEmpty &&
        advanceController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        hourController.text.isNotEmpty &&
        minController.text.isNotEmpty) {
      log('Registering with the following details:');
      log('Name: ${nameController.text}');
      log('WhatsApp Number: ${wanumberController.text}');
      log('Address: ${addressController.text}');
      log('Location: ${locationController.text}');
      log('Branch: ${branchController.text}');
      log('Balance: ${balanceController.text}');
      log('Total: ${totalController.text}');
      log('Advance: ${advanceController.text}');
      log('Date: ${dateController.text}');
      log('Hour: ${hourController.text}');
      log('Minute: ${minController.text}');

      // Navigator.pushReplacementNamed(context, '/regpage');
    } else {
      log('Error: Please fill in all fields');
    }
  }
}
