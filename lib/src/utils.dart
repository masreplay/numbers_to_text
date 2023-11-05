import 'package:intl/intl.dart';

String threeDigitFormat(num number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}

const _englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
const _arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

String toArabicNumber(String input) {
  assert(_englishNumbers.length == _arabicNumbers.length);

  for (int i = 0; i < _englishNumbers.length; i++) {
    input = input.replaceAll(_englishNumbers[i], _arabicNumbers[i]);
  }

  return input;
}

String toEnglishNumber(String input) {
  assert(_englishNumbers.length == _arabicNumbers.length);

  for (int i = 0; i < _englishNumbers.length; i++) {
    input = input.replaceAll(_arabicNumbers[i], _englishNumbers[i]);
  }

  return input;
}
