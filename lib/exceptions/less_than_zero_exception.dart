class LessThanZeroException implements Exception {
  String errorMessage() {
    return '0개보다 많은 개수의 상품만 담을 수 있어요 !';
  }
}
