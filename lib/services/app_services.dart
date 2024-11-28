import 'dart:convert';
import 'package:ayurvedic_centre_patients/models/branch_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'https://flutter-amr.noviindus.in/api/';

//post request
  Future<Map<String, dynamic>> post(
      {required String endpoint, required Map<String, String> body}) async {
    final url = Uri.parse(baseUrl + endpoint);

    try {
      final response = await http.post(
        url,
        body: body,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          "status": false,
          "message": "Server Error: ${response.statusCode}",
        };
      }
    } catch (error) {
      return {
        "status": false,
        "message": "Something went wrong. Please try again.",
      };
    }
  }

//Get request

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse(baseUrl + endpoint);

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          "status": false,
          "message": "Server Error: ${response.statusCode}",
        };
      }
    } catch (error) {
      return {
        "status": false,
        "message": "Something went wrong. Please try again.",
      };
    }
  }

//get branch
  Future<List<Branch>> getBranches() async {
    final url = Uri.parse(baseUrl + 'BranchList');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true && data['branches'] != null) {
          List<dynamic> branchData = data['branches'];
          return branchData
              .map((branchJson) => Branch.fromJson(branchJson))
              .toList();
        } else {
          throw Exception('Failed to load branches');
        }
      } else {
        throw Exception('Failed to load branches');
      }
    } catch (error) {
      rethrow;
    }
  }
}
