//
// class SharedPostModel {
//   int id; // Make it nullable
//
//   final String imageUrl;
//   final String titleText;
//   final String subtitleText;
//   final String breedText;
//   final String priceText;
//
//   SharedPostModel({
//     required this.id, // Initialize it here
//     required this.imageUrl,
//     required this.titleText,
//     required this.subtitleText,
//     required this.breedText,
//     required this.priceText,
//   });
// }
//
//
// List<SharedPostModel> breedCategoryModel = [
//   SharedPostModel(
//     imageUrl: 'images/homeScroll_images/bulldog.jpeg',
//     titleText: 'French bulldogs -\nready for\nChristmas...',
//     subtitleText: 'French BullDog',
//     breedText: 'Rochester',
//     priceText: '\$750', id: 1,
//   ),
//   SharedPostModel(
//     imageUrl: 'images/homeScroll_images/puppy.jpg',
//     titleText: 'Healthy chorkie\npuppies for\nsale',
//     subtitleText: 'Chorkie',
//     breedText: 'Nuneaton',
//     priceText: '\$450', id: 2,
//   ),
//   SharedPostModel(
//     imageUrl: 'images/homeScroll_images/cat.jpg',
//     titleText: 'Two Maine Coon\ngirls',
//     subtitleText: 'Maine Coon',
//     breedText: 'Swindon',
//     priceText: '\$800', id: 3,
//   ),
//   SharedPostModel(
//     imageUrl: 'images/homeScroll_images/rabbit.jpg',
//     titleText: 'Top breed Rabbits\ngirls',
//     subtitleText: 'French Lop',
//     breedText: 'French',
//     priceText: '\$400', id: 4,
//   ),
//
// ];
//
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
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['views'] = this.views;
    data['advertisement_type'] = this.advertisementType;
    data['healthchecked'] = this.healthchecked;
    data['verified'] = this.verified;
    data['status'] = this.status;
    data['date'] = this.date;
    data['categoryid'] = this.categoryid;
    data['userid'] = this.userid;
    data['imagePaths'] = this.imagePaths;
    data['category_title'] = this.categoryTitle;
    return data;
  }
}
