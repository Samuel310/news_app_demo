import 'dart:convert';

News newsFromJson(Map<String, dynamic> str) => News.fromJson(str);

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    required this.status,
    required this.statusCode,
    required this.version,
    required this.lastModified,
    required this.access,
    required this.total,
    required this.limit,
    required this.offset,
    required this.data,
  });

  String status;
  int statusCode;
  String version;
  String lastModified;
  String access;
  int total;
  int limit;
  int offset;
  List<NewsData> data;

  factory News.fromJson(Map<String, dynamic> json) => News(
        status: json["status"],
        statusCode: json["status-code"],
        version: json["version"],
        lastModified: json["last-modified"],
        access: json["access"],
        total: json["total"],
        limit: json["limit"],
        offset: json["offset"],
        data: List<NewsData>.from(json["data"].map((x) => NewsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status-code": statusCode,
        "version": version,
        "last-modified": lastModified,
        "access": access,
        "total": total,
        "limit": limit,
        "offset": offset,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NewsData {
  NewsData({
    required this.id,
    required this.title,
    this.summary,
    required this.link,
    required this.published,
    this.image,
    this.isLiked = false,
  });

  int id;
  String title;
  String? summary;
  String link;
  String published;
  String? image;
  bool isLiked;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        id: json["id"],
        title: json["title"],
        summary: json["summary"] == null ? null : json["summary"],
        link: json["link"],
        published: json["published"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "summary": summary,
        "link": link,
        "published": published,
        "image": image,
      };
}
