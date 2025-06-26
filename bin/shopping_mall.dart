import 'package:shopping_malll/models/product.dart';
import 'package:shopping_malll/services/shopping_cart.dart';
import 'package:shopping_malll/services/shopping_mall.dart';
import 'package:shopping_malll/ui/console_ui.dart';

void main() {
  Product shirt = Product('셔츠', 45000);
  Product dress = Product('원피스', 30000);
  Product tShirt = Product('반팔티', 35000);
  Product shorts = Product('반바지', 38000);
  Product socks = Product('양말', 5000);

  ShoppingMall mall = ShoppingMall();
  mall.products.addAll([shirt, dress, tShirt, shorts, socks]);

  var cart = ShoppingCart();
  var ui = ConsoleUI(mall, cart);
  ui.start();
}
