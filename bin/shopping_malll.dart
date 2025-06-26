import 'package:shopping_malll/shopping_malll.dart' as shopping_malll;

class ShoppingMall {
  List<Product> products = [];
  int total = 0;
  List<Product> cart = [];

  ShoppingMall();

  showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  addToCart(Product product) {
    cart.add(product);
    total += product.price;
  }

  showTotal() {
    print('총 금액: $total원');
  }
}

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

void main(List<String> arguments) {
  print('Hello world: ${shopping_malll.calculate()}!');
}
