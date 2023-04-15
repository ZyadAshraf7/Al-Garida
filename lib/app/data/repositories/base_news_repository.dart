import 'dart:convert';

import '../../core/constants/constants.dart';
import 'package:http/http.dart' as http;

class BaseNewsRepository {
  Future<Map<String, dynamic>> baseNewsRepository(String newsType) async {
    try {
      String baseApi = "https://gnews.io/api/v4/top-headlines?category=$newsType&country=eg&lang=ar&apikey=$NEWS_API_KEY";
      final response = await http.get(Uri.parse(baseApi));
      final Map<String,dynamic> data = jsonDecode(response.body);

      return data;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }
}
