class BreedCategoryModel {
  int? breedId;
  String? breedTitle;
  String? breedDescription;
  String? categoryTitle;
  List<String>? breedImages;

  BreedCategoryModel(
      {this.breedId,
        this.breedTitle,
        this.breedDescription,
        this.categoryTitle,
        this.breedImages});

  BreedCategoryModel.fromJson(Map<String, dynamic> json) {
    breedId = json['breed_id'];
    breedTitle = json['breed_title'];
    breedDescription = json['breed_description'];
    categoryTitle = json['category_title'];
    breedImages = json['breed_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['breed_id'] = breedId;
    data['breed_title'] = breedTitle;
    data['breed_description'] = breedDescription;
    data['category_title'] = categoryTitle;
    data['breed_images'] = breedImages;
    return data;
  }
}