# NumberToText Converter for Flutter

This Flutter package is designed to help you convert numbers into their textual representation in both Arabic and English. It provides a simple and straightforward way to transform numerical values into their equivalent words. Whether you want to convert numbers for display in a user-friendly format or for any other purpose, this package has you covered.

## Features

- Convert numeric values into text in both Arabic and English.
- Easy-to-use API for quick integration into your Flutter application.
- Handles a wide range of numerical values, including integers and decimals.

## Supported Languages
- English = "en"
- Arabic = "ar"

## Usage

1. Add the `numbers_to_text` package to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     numbers_to_text: ^1.0.0
   ```

2. Import the package in your Dart code:

   ```dart
   import 'package:numbers_to_text/numbers_to_text.dart';
   ```

3. Create an instance of the `NumbersToTextConverter` class by specifying the language (either "en" for English or "ar" for Arabic):

   ```dart
   final converter = NumbersToTextConverter("en");
   ```

4. Use the `fromInt` method to convert an integer to its textual representation:

   ```dart
   print(converter.fromInt(0));    // Output: "zero"
   print(converter.fromInt(100));  // Output: "one hundred"
   ```

## Example

Here's a complete example of how to use the `NumbersToTextConverter` in a Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:numbers_to_text/numbers_to_text.dart';

void main() {
  final converter = NumbersToTextConverter("en");

  runApp(MyApp(converter));
}

class MyApp extends StatelessWidget {
  final NumbersToTextConverter converter;

  MyApp(this.converter);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Number to Text Converter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Number: 0'),
              Text('Text: ${converter.fromInt(0)}'),
              Text('Number: 100'),
              Text('Text: ${converter.fromInt(100)}'),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Contributions

Contributions and suggestions for improvements are welcome. If you encounter any issues or have ideas for additional features, please feel free to create a pull request or submit an issue on the [GitHub repository](https://github.com/masreplay/numbers_to_text).

## License

This package is released under the [MIT License](LICENSE). You are free to use, modify, and distribute it as needed, provided you adhere to the terms and conditions of the license.