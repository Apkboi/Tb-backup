import 'dart:io';

void main() {
  final file = File('lib/generated/l10n.dart'); // Adjust this path if necessary
  if (!file.existsSync()) {
    print("S.dart doesn't exist. Exiting...");
    return;
  }

  final content = file.readAsStringSync();

  final regExp = RegExp(r'String get (\w+) {', multiLine: true);
  final matches = regExp.allMatches(content);

  final keys = matches.map((match) => match.group(1)).toList();

  final switchCases = keys
      .map((key) => 'case \'$key\':\n    return S.current.$key;')
      .join('\n');

  final result = '''
  
  import 'package:triberly/generated/l10n.dart';

extension StringLocalization on String {
  String get i18n {
    final convertedString = _toLowerCamelCase(this);

    switch (convertedString) {
      $switchCases
      default:
        return this;
    }
  }

  
  String _toLowerCamelCase(String text) {
    if (text.isEmpty) return text;

    final words = text.trim().split(' ');
    final capitalized = words.map((word) {
      if (word == words.first) return word.toLowerCase();
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    });

    return capitalized.join();
  }
}
  ''';

  final outputFile = File('lib/core/utils/localization_extension.dart');
  outputFile.writeAsStringSync(result);
  print("StringLocalization extension generated successfully!");
}
