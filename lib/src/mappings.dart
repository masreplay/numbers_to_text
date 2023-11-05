import 'dart:math';

abstract class NumberMappings {
  final Map<int, String> numbers;
  final Map<int, String> magnitudes;
  final String andText;
  final String segmentSpacer;
  final String pointText;
  final String zeroText;

  const NumberMappings._(
    this.numbers,
    this.zeroText,
    this.andText,
    this.pointText,
    this.segmentSpacer,
    this.magnitudes,
  );

  String combineLessThan100(String? onesPlaceText, String tensPlaceText);

  String combineLessThan1000(
      int digitAtHundredsPlace, String lastTwoDigitsText);

  static getType(String language) {
    switch (language) {
      case 'ar':
        return ArNumberMappings();
      case 'ku':
        return KuNumberMappings();
      default:
        return EnNumberMappings();
    }
  }
}

class EnNumberMappings implements NumberMappings {
  @override
  Map<int, String> get numbers {
    return {
      1: 'one',
      2: 'two',
      3: 'three',
      4: 'four',
      5: 'five',
      6: 'six',
      7: 'seven',
      8: 'eight',
      9: 'nine',
      10: 'ten',
      11: 'eleven',
      12: 'twelve',
      13: 'thirteen',
      14: 'fourteen',
      15: 'fifteen',
      16: 'sixteen',
      17: 'seventeen',
      18: 'eighteen',
      19: 'nineteen',
      20: 'twenty',
      30: 'thirty',
      40: 'forty',
      50: 'fifty',
      60: 'sixty',
      70: 'seventy',
      80: 'eighty',
      90: 'ninety',
    };
  }

  @override
  Map<int, String> get magnitudes {
    return {
      pow10(2): 'hundred',
      pow10(3): 'thousand',
      pow10(6): 'million',
      pow10(9): 'billion',
      pow10(12): 'trillion',
      pow10(15): 'quadrillion',
      pow10(18): 'quintillion',
    };
  }

  @override
  String get andText => 'and';

  @override
  String get segmentSpacer => ' ';

  @override
  String get pointText => 'point';

  @override
  String get zeroText => 'zero';

  @override
  String combineLessThan100(String? onesPlaceText, String tensPlaceText) {
    if (onesPlaceText == null) return tensPlaceText;
    return '$tensPlaceText-$onesPlaceText';
  }

  @override
  String combineLessThan1000(
      int digitAtHundredsPlace, String lastTwoDigitsText) {
    final hundredDigitText = numbers[digitAtHundredsPlace];
    final hundredMagnitude = magnitudes[100];

    if (hundredDigitText == null) {
      return lastTwoDigitsText;
    } else {
      return '$hundredDigitText$segmentSpacer$hundredMagnitude$segmentSpacer$lastTwoDigitsText';
    }
  }
}

class ArNumberMappings implements NumberMappings {
  @override
  Map<int, String> get numbers {
    return {
      1: 'واحد',
      2: 'اثنان',
      3: 'ثلاثة',
      4: 'أربعة',
      5: 'خمسة',
      6: 'ستة',
      7: 'سبعة',
      8: 'ثمانية',
      9: 'تسعة',
      10: 'عشرة',
      11: 'أحد عشر',
      12: 'اثنا عشر',
      13: 'ثلاثة عشر',
      14: 'أربعة عشر',
      15: 'خمسة عشر',
      16: 'ستة عشر',
      17: 'سبعة عشر',
      18: 'ثمانية عشر',
      19: 'تسعة عشر',
      20: 'عشرون',
      30: 'ثلاثون',
      40: 'أربعون',
      50: 'خمسون',
      60: 'ستين',
      70: 'سبعون',
      80: 'ثمانون',
      90: 'تسعون',
      pow10(2): 'مائة',
      200: 'مائتان',
      300: 'ثلاثمائة',
      400: 'أربعمائة',
      500: 'خمسمائة',
      600: 'ستمائة',
      700: 'سبعمائة',
      800: 'ثمانمائة',
      900: 'تسعمائة',
      pow10(3): 'ألف',
      pow10(3) * 2: 'ألفان',
      pow10(6): 'مليون',
      pow10(6) * 2: 'مليونان',
      pow10(9): 'مليار',
      pow10(9) * 2: 'ملياران',
      pow10(12): 'تريليون',
      pow10(12) * 2: 'تريليونان',
      pow10(15): 'كوادريليون',
      pow10(15) * 2: 'كوادريليونان',
      pow10(18): 'كوينتريليون',
      pow10(18) * 2: 'كوينتريليونان',
    };
  }

  @override
  Map<int, String> get magnitudes {
    return {
      pow10(2): 'مئة',
      pow10(3): 'ألف',
      pow10(6): 'مليون',
      pow10(9): 'مليار',
      pow10(12): 'تريليون',
      pow10(15): 'كوادريليون',
      pow10(18): 'كوينتريليون',
    };
  }

  @override
  String get zeroText => 'صفر';

  @override
  String combineLessThan100(String? onesPlaceText, String tensPlaceText) {
    if (onesPlaceText == null) return tensPlaceText;
    return '$onesPlaceText$segmentSpacer$tensPlaceText';
  }

  @override
  String combineLessThan1000(
      int digitAtHundredsPlace, String lastTwoDigitsText) {
    final hundredWithMagnitude = numbers[digitAtHundredsPlace * 100] ??
        "${numbers[digitAtHundredsPlace]} ${magnitudes[100]}";

    final haveHundredSegment = digitAtHundredsPlace != 0;

    if (haveHundredSegment) {
      if (lastTwoDigitsText.isEmpty) {
        // 100 one hundred
        return hundredWithMagnitude;
      } else {
        // 110 one hundred and ten
        return '$hundredWithMagnitude$segmentSpacer$lastTwoDigitsText';
      }
    } else {
      // 010 ten
      return lastTwoDigitsText;
    }
  }

  @override
  String get andText => 'و';

  @override
  String get pointText => 'فاصلة';

  @override
  String get segmentSpacer => ' $andText ';
}

// TODO(masreplay): https://www.mathsdesign.com/mathematics/numbers-in-different-languages/kurdish-numbers/
class KuNumberMappings implements NumberMappings {
  @override
  Map<int, String> get numbers {
    return {
      1: 'یەک',
      2: 'دوو',
      3: 'سێ',
      4: 'چوار',
      5: 'پێنج',
      6: 'شەش',
      7: 'حەوت',
      8: 'هەشت',
      9: 'نۆ',
      10: 'دە',
      11: 'یازدە',
      12: 'دوازدە',
      13: 'سێزدە',
      14: 'چواردە',
      15: 'پازدە',
      16: 'شازدە',
      17: 'حەڤدە',
      18: 'هەژدە',
      19: 'نۆزدە',
      20: 'بیست',
      30: 'سی',
      40: 'چل',
      50: 'پەنجا',
      60: 'شەست',
      70: 'حەفتا',
      80: 'هەشتا',
      90: 'نەوەت',
    };
  }

  @override
  Map<int, String> get magnitudes {
    return {
      pow10(2): 'سه‌د',
      pow10(3): 'یەك هەزار',
      pow10(6): 'ملیۆن',
      pow10(9): 'يەك بليۆن',
      pow10(12): 'تریلیۆن',
      pow10(15): 'کوادریلیۆن',
      pow10(18): 'کوینتیلیۆن',
    };
  }

  @override
  String get zeroText => 'سفر';

  @override
  String get andText => 'و';

  @override
  String get segmentSpacer => ' ';

  @override
  String get pointText => 'خاڵ';

  @override
  String combineLessThan100(String? onesPlaceText, String tensPlaceText) {
    if (onesPlaceText == null) return tensPlaceText;
    return '$onesPlaceText$segmentSpacer$tensPlaceText';
  }

  @override
  String combineLessThan1000(
      int digitAtHundredsPlace, String lastTwoDigitsText) {
    final hundredDigitText = numbers[digitAtHundredsPlace];

    if (hundredDigitText != null) {
      // 100 one hundred
      final hundredMagnitude = magnitudes[100]!;
      return '$hundredDigitText $hundredMagnitude';
    } else if (hundredDigitText != null && lastTwoDigitsText.isNotEmpty) {
      // 110 one hundred and ten
      return '$hundredDigitText$segmentSpacer$lastTwoDigitsText';
    } else {
      // 010 ten
      return lastTwoDigitsText;
    }
  }
}

int pow10(int exponent) {
  return pow(10, exponent).toInt();
}
