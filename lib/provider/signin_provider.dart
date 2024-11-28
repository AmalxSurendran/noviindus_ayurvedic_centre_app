// ignore_for_file: use_build_context_synchronously, unused_field
import 'dart:developer';
import 'package:ayurvedic_centre_patients/models/patient_model.dart';
import 'package:ayurvedic_centre_patients/models/branch_model.dart';
import 'package:ayurvedic_centre_patients/services/app_services.dart';
import 'package:ayurvedic_centre_patients/services/auth_services.dart';
import 'package:ayurvedic_centre_patients/utlit/shared_prefernce.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/treatment_model.dart';

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
  TextEditingController maleController = TextEditingController();
  TextEditingController femaleController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();
  TextEditingController femalecoController = TextEditingController();
  TextEditingController malecoController = TextEditingController();
  final signformKey = GlobalKey<FormState>();
  final regformKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  String? selectedBranch;
  String? selectedTreatment;
  String? selectedLocation;
  String? _token;
  bool isLoading = true;

  List<Patient> _patients = [];
  List<Patient> get patients => _patients;

  List<Treatment> _treatments = [];
  List<Treatment> get treatments => _treatments;

  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();

  List<String> selectedTreatments = [];

  void addTreatment(String treatment) {
    selectedTreatments.add(treatment);
    notifyListeners();
  }

  void removeTreatment(String treatment) {
    selectedTreatments.remove(treatment);
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void clearToken() {
    _token = null;
    notifyListeners();
  }

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
    final username = emailController.text;
    final password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await _authService.login(username, password);

        if (response['status']) {
          String token = response['token'];
          log("login : $token");

          setToken(token);

          await SharedPreferencesHelper.saveToken(token);

          Navigator.pushReplacementNamed(context, '/homepage');
        } else {
          _showError(context, response['message']);
        }
      } catch (e) {
        log("Login error: $e");
        _showError(
            context, "An error occurred during login. Please try again.");
      }
    } else {
      _showError(context, "Please enter both username and password.");
    }
  }

  // Fetch Patients (Example Future Method)

  Future<void> fetchPatients() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found. Please login first.');
      }

      final headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await _apiService.get(
        endpoint: 'PatientList',
        headers: headers,
      );

      // Check response status
      if (response['status'] == true) {
        final List<dynamic> patientData = response['patient'];
        _patients = patientData.map((json) => Patient.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load patients');
      }
    } catch (e) {
      log('Error fetching patients: $e');
      throw Exception('Error fetching patients: $e');
    }
  }

  // Fetch treatment List (Example Future Method)
  Future<void> fetchtreatment() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found. Please login first.');
      }

      final headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await _apiService.get(
        endpoint: 'TreatmentList',
        headers: headers,
      );

      log('Response: $response');

      if (response['status'] == true && response['treatments'] is List) {
        final List<dynamic> treatmentData = response['treatments'];

        _treatments = treatmentData
            .map((json) {
              try {
                return Treatment.fromJson(json);
              } catch (e) {
                log('Error parsing treatment: $e');
                return null;
              }
            })
            .whereType<Treatment>()
            .toList();

        notifyListeners(); // Notify listeners when the data is updated
      } else {
        throw Exception(
          'Failed to load treatments: ${response['message'] ?? 'Unknown error'}',
        );
      }
    } catch (e) {
      log('Error fetching treatments: $e');
      throw Exception('Error fetching treatments: $e');
    }
  }

  // Fetch Branches List (Example Future Method)

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

//register logic
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
