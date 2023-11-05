import 'mappings.dart';
import 'convertor.dart';

class NumberSplitter {
  final NumberMappings numberMappings;

  const NumberSplitter(this.numberMappings);

  List<NumberSegment> splitNumber(int number) {
    final separatedNumbers = number.toString().split("");
    final segments = <NumberSegment>[];
    var currentNumber = '';
    var segmentNumberText = '';

    for (var i = separatedNumbers.length - 1; i >= 0; i--) {
      segmentNumberText = separatedNumbers[i] + segmentNumberText;

      if (segmentNumberText.length == 3 || i == 0) {
        currentNumber = "$segmentNumberText$currentNumber";

        final magnitude = _getMagnitude(number, segments.length);
        final currentNumberText = int.parse(currentNumber);

        final segment = NumberSegment(
          number: segments.isEmpty
              ? currentNumberText
              : currentNumberText -
                  segments.fold(0, (sum, item) => sum + item.number),
          segmentNumber: int.parse(segmentNumberText),
          magnitude: magnitude,
        );
        segments.insert(0, segment);
        segmentNumberText = '';
      }
    }
    return segments.toList();
  }

  String _getMagnitude(int number, int index) {
    if (number == 0) return '';

    final magnitudes = numberMappings.magnitudes.values.toList();
    final length = 6;

    for (var i = 1; i < magnitudes.length; i++) {
      if (index % length == i) return ' ${magnitudes[i]}';
    }
    return '';  
  }
}
