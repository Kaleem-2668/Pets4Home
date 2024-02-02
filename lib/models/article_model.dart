  /// id : 40
  /// title : "German Shepherd"
  /// description : "During the 1890s, attempts were being made to standardise dog breeds.[5] Dogs were being bred to preserve traits that assisted in their job of herding sheep and protecting their flocks from predators.[6] In Germany this was practised within local communities, where shepherds selected and bred dogs. It was recognised that the breed had the necessary skills for herding sheep, such as intelligence, speed, strength and keen senses of smell.[6] The results were dogs that were able to do such things, but that differed significantly, both in appearance and ability, from one locality to another."
  /// image : "articles/image_1706466650804.jpg"
  /// categoryName : "Dog"

  class ArticleModel {
    int? id;
    String? title;
    String? description;
    String? image;
    String? categoryName;

    ArticleModel(
        {this.id, this.title, this.description, this.image, this.categoryName});

    ArticleModel.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      title = json['title'];
      description = json['description'];
      image = json['image'];
      categoryName = json['categoryName'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = id;
      data['title'] = title;
      data['description'] = description;
      data['image'] = image;
      data['categoryName'] = categoryName;
      return data;
    }
  }
