class CategoryModel {
  int? categoryid;
  String? categoryName;
  String? description;
  String? image;

  CategoryModel(
      {this.categoryid, this.categoryName, this.description, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryid = json['categoryid'];
    categoryName = json['categoryName'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryid'] = categoryid;
    data['categoryName'] = categoryName;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
