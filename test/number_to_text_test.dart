import 'package:numbers_to_text/src/convertor.dart';
import 'package:test/test.dart';

void main() {
  group('Arabic number to text converter test', () {
    final converter = NumbersToTextConverter("ar");

    setUp(() {});

    test('thousands and fraction', () {
      // add bracket around the number to make it clear
      expect(converter.fromInt(1250), "ألف و مائتان و خمسون");
    });
    test('First Test', () {
      expect(converter.fromInt(1000), "الف");
    });
  });
}
