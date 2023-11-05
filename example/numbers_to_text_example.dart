import 'package:numbers_to_text/numbers_to_text.dart';

void main(List<String> args) {
  final convertor = NumbersToTextConverter("en");

  print(convertor.fromInt(0));
  print(convertor.fromInt(100));
}
