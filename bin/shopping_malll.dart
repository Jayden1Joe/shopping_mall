import 'package:shopping_malll/shopping_malll.dart' as shopping_malll;
import 'dart:io';

class LessThanZeroException implements Exception {
  String errorMessage() {
    return '0개보다 많은 개수의 상품만 담을 수 있어요 !';
  }
}

class ShoppingMall {
  List<Product> products = [];
  int total = 0;
  List<CartItem> cart = [];

  ShoppingMall();

  showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  addToCart(CartItem item) {
    cart.add(item);
    total += item.product.price * item.quantity;
  }

  showTotal() {
    print('장바구니에 $total원 어치를 담으셨네요 !');
  }
}

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class CartItem {
  Product product;
  int quantity;

  CartItem(this.product, this.quantity);
}

void main(List<String> arguments) {
  Product shirt = Product('셔츠', 45000);
  Product dress = Product('원피스', 30000);
  Product tShirt = Product('반팔티', 35000);
  Product shorts = Product('반바지', 38000);
  Product socks = Product('양말', 5000);

  ShoppingMall shoppingMall = ShoppingMall();
  shoppingMall.products.addAll([shirt, dress, tShirt, shorts, socks]);
  bool loop = true;

  while (loop) {
    print(
      '''------------------------------------------------------------------------------------------------------
[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료
------------------------------------------------------------------------------------------------------''',
    );

    String? input = stdin.readLineSync();
    switch (input) {
      case '1':
        shoppingMall.showProducts();
      case '2':
        print('상품 이름을 입력해주세요 !');
        String? productName = stdin.readLineSync();
        print('상품 개수를 입력해주세요 !');

        int? productQuantity = int.tryParse(stdin.readLineSync() ?? '');

        if (!shoppingMall.products.any((p) => p.name == productName) ||
            productQuantity == null) {
          print('입력값이 올바르지 않아요 !');
        } else if (productQuantity <= 0) {
          throw LessThanZeroException();
        } else {
          Product product = shoppingMall.products.firstWhere(
            (p) => p.name == productName,
          );
          CartItem item = CartItem(product, productQuantity);
          shoppingMall.addToCart(item);
          print('장바구니에 상품이 담겼어요 !');
        }
      case '3':
        shoppingMall.showTotal();
      case '4':
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
        loop = false;
    }
  }
}
