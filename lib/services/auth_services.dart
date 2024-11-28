import 'package:ayurvedic_centre_patients/services/app_services.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final body = {
      "username": username,
      "password": password,
    };
    return await _apiService.post(endpoint: 'Login', body: body);
  }
}
