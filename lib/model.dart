// To parse this JSON data, do
//
//     final homeListDataRaw = homeListDataRawFromJson(jsonString);

import 'dart:convert';

ListDataRaw listDataRawFromJson(String str) =>
    ListDataRaw.fromJson(json.decode(str));

String listDataRawToJson(ListDataRaw data) => json.encode(data.toJson());

class ListDataRaw {
  ListDataRaw({
    this.success,
    this.data,
    this.message,
    this.errorCode,
  });

  bool success;
  ListData data;
  String message;
  String errorCode;

  factory ListDataRaw.fromJson(Map<String, dynamic> json) => ListDataRaw(
        success: json["success"],
        data: ListData.fromJson(json["data"]),
        message: json["message"],
        errorCode: json["errorCode"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
        "errorCode": errorCode,
      };
}

class ListData {
  ListData({
    this.list,
    this.total,
  });

  List<ListItem> list;
  int total;

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        list:
            List<ListItem>.from(json["list"].map((x) => ListItem.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "total": total,
      };
}

class ListItem {
  ListItem({
    this.type,
    this.article,
    this.channel,
    this.createdAt,
  });

  Type type;
  Article article;
  Channel channel;
  DateTime createdAt;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        type: typeValues.map[json["type"]],
        article: Article.fromJson(json["article"]),
        channel: Channel.fromJson(json["channel"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "article": article.toJson(),
        "channel": channel.toJson(),
        "createdAt": createdAt.toIso8601String(),
      };
}

class Article {
  Article({
    this.articleId,
    this.title,
    this.cover,
  });

  String articleId;
  String title;
  String cover;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        articleId: json["articleId"],
        title: json["title"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "articleId": articleId,
        "title": title,
        "cover": cover,
      };
}

class Channel {
  Channel({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

enum Type { ARTICLE }

final typeValues = EnumValues({"article": Type.ARTICLE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
