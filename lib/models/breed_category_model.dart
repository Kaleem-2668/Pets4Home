// class BreedCategoryModel{
//   late final int? id;
//   final String imageUrl;
//   final String titleText;
//   final String subtitleText;
//   final String breedText;
//   final String priceText;
//
//
//
//   BreedCategoryModel({
//     this.id,
//     required this.imageUrl,
//     required this.titleText,
//     required this.subtitleText,
//     required this.breedText,
//     required this.priceText,
//
//   });
// }
// List<BreedCategoryModel>breedCategoryModel=
// [
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/bulldog.jpeg',
//       titleText: 'French bulldogs -\nready for\nChristmas...',
//       subtitleText: 'French BullDog',
//       breedText:'Rochester',
//       priceText: '\$750'),
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/puppy.jpg',
//       titleText: 'Healthy chorkie\npuppies for\nsale',
//       subtitleText: 'Chorkie',
//       breedText:'Nuneaton',
//       priceText: '\$450'),
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/cat.jpg',
//       titleText: 'Two Maine Coon\ngirls',
//       subtitleText: 'Maine Coon',
//       breedText:'Swindon',
//       priceText: '\$800'),
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/rabbit.jpg',
//       titleText: 'Top breed Rabbits\ngirls',
//       subtitleText: 'French Lop',
//       breedText:'French',
//       priceText: '\$400'),
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/bulldog.jpeg',
//       titleText: 'French bulldogs -\nready for\nChristmas...',
//       subtitleText: 'French BullDog',
//       breedText:'Rochester',
//       priceText: '\$750'),
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/rabbit.jpg',
//       titleText: 'Top breed Rabbits\ngirls',
//       subtitleText: 'French Lop',
//       breedText:'French',
//       priceText: '\$400'),
//
//
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/cat.jpg',
//       titleText: 'Two Maine Coon\ngirls',
//       subtitleText: 'Maine Coon',
//       breedText:'Swindon',
//       priceText: '\$800'),
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/cat.jpg',
//       titleText: 'Two Maine Coon\ngirls',
//       subtitleText: 'Maine Coon',
//       breedText:'Swindon',
//       priceText: '\$800'),
//   BreedCategoryModel(
//       imageUrl: 'images/homeScroll_images/cat.jpg',
//       titleText: 'Two Maine Coon\ngirls',
//       subtitleText: 'Maine Coon',
//       breedText:'Swindon',
//       priceText: '\$800'),
//
//
// ];
//
class BreedCategoryModel {
  int id; // Make it nullable

  final String imageUrl;
  final String titleText;
  final String subtitleText;
  final String breedText;
  final String priceText;

  BreedCategoryModel({
    required this.id, // Initialize it here
    required this.imageUrl,
    required this.titleText,
    required this.subtitleText,
    required this.breedText,
    required this.priceText,
  });
}


List<BreedCategoryModel> breedCategoryModel = [
  BreedCategoryModel(
    imageUrl: 'images/homeScroll_images/bulldog.jpeg',
    titleText: 'French bulldogs -\nready for\nChristmas...',
    subtitleText: 'French BullDog',
    breedText: 'Rochester',
    priceText: '\$750', id: 1,
  ),
  BreedCategoryModel(
    imageUrl: 'images/homeScroll_images/puppy.jpg',
    titleText: 'Healthy chorkie\npuppies for\nsale',
    subtitleText: 'Chorkie',
    breedText: 'Nuneaton',
    priceText: '\$450', id: 2,
  ),
  BreedCategoryModel(
    imageUrl: 'images/homeScroll_images/cat.jpg',
    titleText: 'Two Maine Coon\ngirls',
    subtitleText: 'Maine Coon',
    breedText: 'Swindon',
    priceText: '\$800', id: 3,
  ),
  BreedCategoryModel(
    imageUrl: 'images/homeScroll_images/rabbit.jpg',
    titleText: 'Top breed Rabbits\ngirls',
    subtitleText: 'French Lop',
    breedText: 'French',
    priceText: '\$400', id: 4,
  ),

];
