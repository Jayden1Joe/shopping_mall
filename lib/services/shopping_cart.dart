import 'package:shopping_mall/utils/subjectParticle.dart';
import '../models/cart_item.dart';

class ShoppingCart {
  List<CartItem> cart = [];
  int total = 0;

  void addToCart(CartItem item) {
    // 이미 장바구니에 같은 상품이 있다면 수량을 증가시키고, 없다면 새로 추가
    if (cart.any((cartItem) => cartItem.product.name == item.product.name)) {
      CartItem existingItem = cart.firstWhere(
        (cartItem) => cartItem.product.name == item.product.name,
      );
      existingItem.quantity += item.quantity;
    } else {
      cart.add(item);
    }
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
}
