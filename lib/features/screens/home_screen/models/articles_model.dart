import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:jo_news/core/constants/app_constants.dart';

class ArticlesModels {
  String? status;
  int? totalResults;
  List<Article> articles;

  ArticlesModels({this.status, this.totalResults, required this.articles});

  factory ArticlesModels.fromJson(Map<String, dynamic> json) => ArticlesModels(
    status: json['status'],
    totalResults: json['totalResults'],
    articles: json['articles'] == null
        ? []
        : List<Article>.from(json['articles'].map((x) => Article.fromJson(x))),
  );
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String safeImage(String? url) {
    if (url == null ||
        url.trim().isEmpty ||
        url == 'null' ||
        !url.startsWith('http') ||
        url.contains('aljazeera.net')) {
      return AppConstants.defaultImage;
    }

    return url;
  }

  DateTime? publishedAt;

  String get safeDate => publishedAt != null
      ? DateFormat('MMMM d, yyyy').format(publishedAt!)
      : 'unknownDate';
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: json['source'] == null ? null : Source.formJson(json['source']),
    author: json['author'],
    title: json['title'],
    url: json['url'],
    urlToImage: json['urlToImage'],
    publishedAt: json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt']),
    description: json['description'],
    content: json['content'],
  );
}

class Source {
  String? id;
  String? name;
  Source({this.id, this.name});

  factory Source.formJson(Map<String, dynamic> json) =>
      Source(id: json['id'], name: json['name']);
}
