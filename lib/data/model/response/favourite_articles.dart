// import 'package:news_app/data/model/artical_model.dart';

// class FavouriteArticles {
//   List<Article> articles;

//   FavouriteArticles({this.articles});

//   FavouriteArticles.fromJson(Map<String, dynamic> json) {
//     if (json['articles'] != null) {
//       articles = <Article>[];
//       json['articles'].forEach((v) {
//         articles.add(new Article.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['totalResults'] = this.totalResults;
//     if (this.articles != null) {
//       data['articles'] = this.articles.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
