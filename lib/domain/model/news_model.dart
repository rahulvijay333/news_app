import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'news_model.g.dart';


class NewsModel {
  
    final List<Article>? articles;

    NewsModel({
        this.articles,
    });

    factory NewsModel.fromJson(String str) => NewsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        articles: json["articles"] == null ? [] : List<Article>.from(json["articles"]!.map((x) => Article.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "articles": articles == null ? [] : List<dynamic>.from(articles!.map((x) => x.toMap())),
    };
}

@HiveType(typeId: 1)
class Article {
    @HiveField(1)
    final Source? source;
    @HiveField(2)
    final String? author;
    @HiveField(3)
    final String? title;
    @HiveField(4)
    final dynamic description;
    @HiveField(5)
    final String? url;
    @HiveField(6)
    final dynamic urlToImage;
    @HiveField(7)
    final DateTime? publishedAt;
    @HiveField(8)
    final dynamic content;

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

    factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Article.fromMap(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromMap(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"] ,
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toMap() => {
        "source": source?.toMap(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
    };
}

@HiveType(typeId: 3)
class Source {
    @HiveField(1)
    final String? id;
    @HiveField(2)
    final String? name;

    Source({
        this.id,
        this.name,
    });

    factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Source.fromMap(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
