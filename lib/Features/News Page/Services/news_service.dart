import 'dart:convert';

import 'package:news_project/Model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final DateTime now = DateTime.now().subtract(Duration(days: 2));
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

class NewsRepo {
  Future<NewsModel> _fetch_news(String text) async {
    String url =
        'https://api.worldnewsapi.com/search-news?api-key=2afb76085b5f486aaec73d1b09da7902&text=${text}&earliest-publish-date=$formatted';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(response.body);
      return NewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}

class NewsService {
  final _api = NewsRepo();
  Future<NewsModel> fetch_news(String text) async {
    final res = await _api._fetch_news(text);
    return res;
  }
}
