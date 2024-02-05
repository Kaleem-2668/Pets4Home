
class SharedPostModel {
  int id; // Make it nullable

  final String imageUrl;
  final String titleText;
  final String subtitleText;
  final String breedText;
  final String priceText;

  SharedPostModel({
    required this.id, // Initialize it here
    required this.imageUrl,
    required this.titleText,
    required this.subtitleText,
    required this.breedText,
    required this.priceText,
  });
}


List<SharedPostModel> breedCategoryModel = [
  SharedPostModel(
    imageUrl: 'images/homeScroll_images/bulldog.jpeg',
    titleText: 'French bulldogs -\nready for\nChristmas...',
    subtitleText: 'French BullDog',
    breedText: 'Rochester',
    priceText: '\$750', id: 1,
  ),
  SharedPostModel(
    imageUrl: 'images/homeScroll_images/puppy.jpg',
    titleText: 'Healthy chorkie\npuppies for\nsale',
    subtitleText: 'Chorkie',
    breedText: 'Nuneaton',
    priceText: '\$450', id: 2,
  ),
  SharedPostModel(
    imageUrl: 'images/homeScroll_images/cat.jpg',
    titleText: 'Two Maine Coon\ngirls',
    subtitleText: 'Maine Coon',
    breedText: 'Swindon',
    priceText: '\$800', id: 3,
  ),
  SharedPostModel(
    imageUrl: 'images/homeScroll_images/rabbit.jpg',
    titleText: 'Top breed Rabbits\ngirls',
    subtitleText: 'French Lop',
    breedText: 'French',
    priceText: '\$400', id: 4,
  ),

];

