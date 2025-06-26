import 'package:shopping_mall/services/shopping_cart.dart';

void printReceipt(ShoppingCart cart) {
  if (cart.total == 0) {
    print('장바구니가 비어있습니다.');
    return;
  }

  print('                     영수증');
  print('----------------------------------------------');
  print('상품명            |   단가   | 수량 |     합계');
  print('----------------------------------------------');

  for (var item in cart.cart) {
    final name = item.product.name.padRight(15);
    final price = item.product.price.toString().padLeft(6);
    final quantity = item.quantity.toString().padLeft(4);
    final sum = (item.product.price * item.quantity).toString().padLeft(6);
    print('$name | $price원 | $quantity | $sum원');
  }

  print('----------------------------------------------');
  print('총 합계: ${cart.total}원');
  print('----------------------------------------------');
}
