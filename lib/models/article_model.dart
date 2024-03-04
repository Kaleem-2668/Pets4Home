class ArticleModel {
  int? totalItems;
  String? currentPage;
  int? totalPages;
  List<Articles>? articles;

  ArticleModel(
      {this.totalItems, this.currentPage, this.totalPages, this.articles});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = totalItems;
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  int? id;
  String? title;
  String? description;
  String? image;
  String? categoryName;

  Articles(
      {this.id, this.title, this.description, this.image, this.categoryName});

  Articles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['categoryName'] = categoryName;
    return data;
  }
}
