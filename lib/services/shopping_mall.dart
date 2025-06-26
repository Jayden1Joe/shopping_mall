import 'package:shopping_malll/models/product.dart';

class ShoppingMall {
  List<Product> products = [];
  int total = 0;

  ShoppingMall();

  showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  String subjectParticle(String word) {
    final lastChar = word[word.length - 1];
    final codeUnit = lastChar.codeUnitAt(0);
    final hasFinalConsonant = (codeUnit - 0xAC00) % 28 != 0;
    return hasFinalConsonant ? '이' : '가';
  }
}
