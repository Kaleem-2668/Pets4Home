
class SharedPostModel {
  int? id;
  String? title;
  String? description;
  String? price;
  String? address;
  int? latitude;
  int? longitude;
  String? city;
  int? views;
  String? advertisementType;
  String? healthchecked;
  String? verified;
  int? status;
  int? date;
  int? categoryid;
  int? userid;
  List<String>? imagePaths;
  String? categoryTitle;

  SharedPostModel(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.address,
        this.latitude,
        this.longitude,
        this.city,
        this.views,
        this.advertisementType,
        this.healthchecked,
        this.verified,
        this.status,
        this.date,
        this.categoryid,
        this.userid,
        this.imagePaths,
        this.categoryTitle});

  SharedPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    views = json['views'];
    advertisementType = json['advertisement_type'];
    healthchecked = json['healthchecked'];
    verified = json['verified'];
    status = json['status'];
    date = json['date'];
    categoryid = json['categoryid'];
    userid = json['userid'];
    imagePaths = json['imagePaths'].cast<String>();
    categoryTitle = json['category_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['city'] = city;
    data['views'] = views;
    data['advertisement_type'] = advertisementType;
    data['healthchecked'] = healthchecked;
    data['verified'] = verified;
    data['status'] = status;
    data['date'] = date;
    data['categoryid'] = categoryid;
    data['userid'] = userid;
    data['imagePaths'] = imagePaths;
    data['category_title'] = categoryTitle;
    return data;
  }
}

