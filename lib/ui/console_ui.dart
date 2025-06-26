import 'dart:io';

import 'package:shopping_mall/exceptions/less_than_zero_exception.dart';
import 'package:shopping_mall/models/cart_item.dart';
import 'package:shopping_mall/models/product.dart';
import 'package:shopping_mall/services/shopping_cart.dart';
import 'package:shopping_mall/services/shopping_mall.dart';
import 'package:shopping_mall/ui/receipt_printer.dart';

class ConsoleUI {
  final ShoppingMall mall;
  final ShoppingCart cart;

  ConsoleUI(this.mall, this.cart);

  void start() {
    bool loop = true;
    while (loop) {
      print(
        '''--------------------------------------------------------------------------------------------------------------------------------------------------------------
[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [5] 종료 확인 / [6] 장바구니 초기화 / [7] 영수증 출력
--------------------------------------------------------------------------------------------------------------------------------------------------------------''',
      );
      String? input = stdin.readLineSync();
      switch (input) {
        case '1':
          mall.showProducts();
        case '2':
          _addToCart();
        case '3':
          cart.showTotal();
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
          if (cart.total == 0) {
            print('이미 장바구니가 비어있습니다.');
          } else {
            cart.cart.clear();
            cart.total = 0;
            print('장바구니를 초기화합니다.');
          }
        case '7':
          printReceipt(cart);
        default:
          print('잘못된 입력입니다. 1~6의 숫자를 눌러주세요.');
      }
    }
  }

  void _addToCart() {
    print('상품 이름을 입력해주세요 !');
    String? productName = stdin.readLineSync();
    print('상품 개수를 입력해주세요 !');
    try {
      int? productQuantity = int.parse(stdin.readLineSync() ?? '');
      if (!mall.products.any((p) => p.name == productName)) {
        // 상품 이름이 목록에 없는 경우
        throw Exception();
      } else if (productQuantity <= 0) {
        // 상품 개수가 0 이하인 경우
        throw LessThanZeroException();
      } else {
        // 리스트내 이름과 입력받은 이름이 일치하는 상품을 찾고 장바구니에 추가
        Product product = mall.products.firstWhere(
          (p) => p.name == productName,
        );
        CartItem item = CartItem(product, productQuantity);
        cart.addToCart(item);
        print('장바구니에 상품이 담겼어요 !');
      }
    } on LessThanZeroException catch (e) {
      print(e.errorMessage());
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
    }
  }
}
