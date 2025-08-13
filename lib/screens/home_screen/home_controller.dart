
import 'package:get/get.dart';

class HomeController extends GetxController{
var categoryList =  [
  "All",
  "Cleanser",
  "Sunscreen",
  "Serum",
  "Face Oil",
  "Moisturizer"
];

var onTapCategory  =0.obs;


final List<Map<String, String>> products = [
  {"name": "AHA/BHA Toner", "image": "https://m.media-amazon.com/images/I/31Tqh9PbZGL._SR290,290_.jpg"},
  {"name": "Matte Sun Stick", "image": "https://m.media-amazon.com/images/I/51dCdveo-qL.jpg"},
  {"name": "Face Cleanser", "image": "https://m.media-amazon.com/images/I/51RZjGsfF5L._UF1000,1000_QL80_.jpg"},
  {"name": "Moisturizing Cream", "image": "https://m.media-amazon.com/images/I/419wOlkkGqL._SR290,290_.jpg"},
];

}