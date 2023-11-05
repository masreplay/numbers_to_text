import 'package:number_to_text/src/splitter.dart';

import 'mappings.dart';

// 1810
class NumberSegment {
  // 1
  final int segmentNumber;
  // 1000
  final int number;
  final String magnitude;

  const NumberSegment({
    required this.segmentNumber,
    required this.magnitude,
    required this.number,
  });

  @override
  String toString() =>
      'NumberSegment(segmentNumber: $segmentNumber, number: $number, magnitude: $magnitude)';
}

class NumberToTextConverter {
  final String language;
  final NumberMappings mapper;
  late final NumberSplitter splitter;

  NumberToTextConverter.en() : this("en");
  NumberToTextConverter.ar() : this("ar");
  
  NumberToTextConverter(this.language)
      : mapper = NumberMappings.getType(language) {
    splitter = NumberSplitter(mapper);
  }
  String fromNum(num number) {
    if (number is int) {
      return fromInt(number);
    } else if (number is double) {
      return fromDouble(number);
    }
    return "";
  }

  String fromInt(int number) {
    return convertNumberToText(number);
  }

  String fromDouble(double number) {
    final decimal = number.toString().split('.');

    final leftNumber = int.parse(decimal.first);
    final rightNumber = int.parse(decimal.last);

    var textNumber = convertNumberToText(leftNumber);

    if (rightNumber != 0) {
      return "$textNumber ${mapper.pointText} ${convertNumberToText(rightNumber)}";
    }

    return textNumber;
  }

  String convertNumberToText(int number) {
    if (number < 0) {
      throw Exception('Cannot convert negative numbers');
    }

    if (number == 0) return mapper.zeroText;

    final segments = splitter.splitNumber(number);

    var numberText = '';

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];

      if (language == "ar") {
        final segmentNumberText = getNumberText(segment.number);
        if (segmentNumberText != null) {
          final shouldAddSpace = numberText.isNotEmpty;
          if (shouldAddSpace) numberText += mapper.segmentSpacer;
          numberText += segmentNumberText;
          continue;
        }
      }

      if (segment.segmentNumber != 0) {
        final segmentText = getTextForNumberLessThan1000(segment.segmentNumber);
        final shouldAddSpace = numberText.isNotEmpty && segmentText.isNotEmpty;

        if (shouldAddSpace) numberText += mapper.segmentSpacer;
        numberText += segmentText + segment.magnitude;
      }
    }

    return numberText.trim();
  }

  String getTextForNumberLessThan1000(int number) {
    final numberText = getNumberText(number);
    if (numberText != null) return numberText;

    final lastTwoDigits = number % 100;
    final lastTwoDigitsText =
        lastTwoDigits == 0 ? "" : getTextForNumberLessThan100(lastTwoDigits);

    final digitAtHundredsPlace = number ~/ 100;

    return mapper.combineLessThan1000(
      digitAtHundredsPlace,
      lastTwoDigitsText,
    );
  }

  // 85
  // if 85.exist() return 85.text("ar")
  // 85 % 10 = 5
  // 85 - 5 = 80
  // 80 % 100 = 80
  // return 80.text("ar") 5.text("ar")
  String getTextForNumberLessThan100(int number) {
    if (number < 0 && number > 99) {
      throw ArgumentError('Number must be between 0 and 99');
    }

    final numberText = getNumberText(number);
    if (numberText != null) return numberText;

    final onesPlace = (number % 10).toInt();
    final onesPlaceText = getNumberText(onesPlace)!;

    final tensPlace = (number - onesPlace) % 100;
    final tensPlaceText = getNumberText(tensPlace)!;

    return mapper.combineLessThan100(onesPlaceText, tensPlaceText);
  }

  String? getNumberText(int number) {
    return mapper.numbers[number];
  }
}
