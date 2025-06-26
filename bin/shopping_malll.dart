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
    // 장바구니에 이미 같은 상품이 있는지 확인
    if (cart.any((cartItem) => cartItem.product.name == item.product.name)) {
      // 이미 있는 경우, 해당 상품의 수량을 증가시킴
      CartItem existingItem = cart.firstWhere(
        (cartItem) => cartItem.product.name == item.product.name,
      );
      existingItem.quantity += item.quantity;
    } else {
      // 없는 경우, 새로 추가
      cart.add(item);
    }
    // 총 가격 업데이트
    total += item.product.price * item.quantity;
  }

  showTotal() {
    if (total == 0) {
      print('장바구니에 담긴 상품이 없습니다.');
    } else {
      List<String> names = cart.map((item) => item.product.name).toList();
      String productNames = names.join(', ');
      String particle = subjectParticle(names.last); // 마지막 상품 기준으로 조사 선택

      print('장바구니에 $productNames$particle 담겨있네요. 총 $total원 입니다!');
    }
  }

  String subjectParticle(String word) {
    final lastChar = word[word.length - 1];
    final codeUnit = lastChar.codeUnitAt(0);
    final hasFinalConsonant = (codeUnit - 0xAC00) % 28 != 0;
    return hasFinalConsonant ? '이' : '가';
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

void printReceipt(ShoppingMall shoppingMall) {
  if (shoppingMall.total == 0) {
    print('장바구니가 비어있습니다.');
    return;
  }

  print('                     영수증');
  print('----------------------------------------------');
  print('상품명            |   단가   | 수량 |     합계');
  print('----------------------------------------------');

  for (var item in shoppingMall.cart) {
    final name = item.product.name.padRight(15);
    final price = item.product.price.toString().padLeft(6);
    final quantity = item.quantity.toString().padLeft(4);
    final sum = (item.product.price * item.quantity).toString().padLeft(6);
    print('$name | $price원 | $quantity | $sum원');
  }

  print('----------------------------------------------');
  print('총 합계: ${shoppingMall.total}원');
  print('----------------------------------------------');
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
      '''--------------------------------------------------------------------------------------------------------------------------------------------
[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [5] 종료 확인 / [6] 장바구니 초기화
--------------------------------------------------------------------------------------------------------------------------------------------''',
    );

    String? input = stdin.readLineSync();
    switch (input) {
      case '1':
        shoppingMall.showProducts();
      case '2':
        print('상품 이름을 입력해주세요 !');
        String? productName = stdin.readLineSync();
        print('상품 개수를 입력해주세요 !');
        try {
          int? productQuantity = int.parse(stdin.readLineSync() ?? '');
          if (!shoppingMall.products.any((p) => p.name == productName)) {
            // 상품 이름이 목록에 없는 경우
            throw Exception();
          } else if (productQuantity <= 0) {
            // 상품 개수가 0 이하인 경우
            throw LessThanZeroException();
          } else {
            // 리스트내 이름과 입력받은 이름이 일치하는 상품을 찾고 장바구니에 추가
            Product product = shoppingMall.products.firstWhere(
              (p) => p.name == productName,
            );
            CartItem item = CartItem(product, productQuantity);
            shoppingMall.addToCart(item);
            print('장바구니에 상품이 담겼어요 !');
          }
        } catch (e) {
          print('입력값이 올바르지 않아요 !');
        }
      case '3':
        shoppingMall.showTotal();
      case '4':
        print('정말 종료하시겠습니까?');
        String? exitInput = stdin.readLineSync();
        if (exitInput == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
          loop = false;
        } else {
          print('종료하지 않습니다.');
        }
      case '6':
        if (shoppingMall.total == 0) {
          print('이미 장바구니가 비어있습니다.');
        } else {
          shoppingMall.cart.clear();
          shoppingMall.total = 0;
          print('장바구니를 초기화합니다.');
        }
      case '7':
        printReceipt(shoppingMall);
      default:
        print('잘못된 입력입니다. 1~6의 숫자를 눌러주세요.');
    }
  }
}
