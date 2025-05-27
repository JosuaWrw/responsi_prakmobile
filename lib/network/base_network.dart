import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static const String baseUrl =
      'https://681388b3129f6313e2119693.mockapi.io/api/v1/';

  static Future<List<dynamic>> getData(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List) {
          return data;
        } else if (data is Map && data.containsKey(endpoint)) {
          return data[endpoint] ?? [];
        } else {
          return [data];
        }
      } else {
        throw Exception('Failed to load data! Status: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Map<String, dynamic>> getDetailData(
    String endpoint,
    int id,
  ) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + '$endpoint/$id'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List && data.isNotEmpty) {
          return data.first;
        } else if (data is Map<String, dynamic>) {
          return data;
        } else {
          throw Exception('Unexpected data format!');
        }
      } else {
        throw Exception('Failed to load detail data!');
      }
    } catch (e) {
      throw e;
    }
  }
}
