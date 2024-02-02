class CategoryWiseModel {
  bool? success;
  String? message;
  List<Data>? data;

  CategoryWiseModel({this.success, this.message, this.data});

  CategoryWiseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? title;
  String? description;
  String? image;
  int? categoryid;
  String? categoryName;

  Data(
      {this.title,
        this.description,
        this.image,
        this.categoryid,
        this.categoryName});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    categoryid = json['categoryid'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['categoryid'] = categoryid;
    data['categoryName'] = categoryName;
    return data;
  }
}
