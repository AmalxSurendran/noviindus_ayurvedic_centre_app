import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class HttpHandler {
  static const String baseUrl = "https://flutter-amr.noviindus.in/api/";

  // POST Method
  static Future<dynamic> httpPOST({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    final Uri url = Uri.parse("$baseUrl$endpoint");
    final headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await http
          .post(
            url,
            headers: headers,
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        log("HTTP POST Error: ${response.statusCode} ${response.body}");
        return {"error": "HTTP Error: ${response.statusCode}"};
      }
    } catch (e) {
      log("Error: $e");
      return {"error": "Unknown error: $e"};
    }
  }

  // GET Method
  static Future<dynamic> httpGET({required String endpoint}) async {
    final Uri url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        log("HTTP GET Error: ${response.statusCode} ${response.body}");
        return {"error": "HTTP Error: ${response.statusCode}"};
      }
    } catch (e) {
      log("Error: $e");
      return {"error": "Unknown error: $e"};
    }
  }
}
