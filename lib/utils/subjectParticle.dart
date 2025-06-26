String subjectParticle(String word) {
  final lastChar = word[word.length - 1];
  final codeUnit = lastChar.codeUnitAt(0);
  final hasFinalConsonant = (codeUnit - 0xAC00) % 28 != 0;
  return hasFinalConsonant ? '이' : '가';
}
