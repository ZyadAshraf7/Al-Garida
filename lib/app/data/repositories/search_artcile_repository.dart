import 'dart:convert';

import 'package:the_news/app/data/models/news_model.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/constants.dart';

class SearchArticleRepository{

  Future<Map<String,dynamic>> searchArticle(String searchKeyword)async{
    try{
      String searchAPI = 'https://gnews.io/api/v4/search?q=$searchKeyword&lang=ar&country=eg&max=10&apikey=' + NEWS_API_KEY;
      final response = await http.get(Uri.parse(searchAPI));
      Map<String,dynamic> data = jsonDecode(response.body);
      return data;
    }catch(e){
      print(e.toString());
      return {};
    }
  }
}