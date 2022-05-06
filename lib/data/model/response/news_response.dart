import 'package:news_app/data/model/artical_model.dart';

class NewsResponse {
  String status;
  int totalResults;
  List<ArticleModel> articles;

  NewsResponse({this.status, this.totalResults, this.articles});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <ArticleModel>[];
      json['articles'].forEach((v) {
        articles.add(new ArticleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
