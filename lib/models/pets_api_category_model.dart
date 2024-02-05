class PetsApiCategory {
  int? id;
  String? title;
  String? description;
  String? image;
  String? createdAt;

  PetsApiCategory(
      {this.id, this.title, this.description, this.image, this.createdAt});

  PetsApiCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
