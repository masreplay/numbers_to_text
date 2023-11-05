import 'package:number_to_text/number_to_text.dart';

void main(List<String> args) {
  final convertor = NumberToTextConverter("en");

  print(convertor.fromInt(0));
  print(convertor.fromInt(100));
}
