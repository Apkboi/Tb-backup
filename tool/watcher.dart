import 'dart:io';
import 'package:triberly/core/services/_services.dart';

import 'generate_extension.dart' as generator;

void main() {
  final file = File('lib/generated/intl/l10n.dart');

  if (!file.existsSync()) {
    print("Error: l10n.dart doesn't exist at specified path.");
    return;
  }

  // directory.watch().listen((event) {
  //   print('message');
  //   // if (event.path.contains('l10n.dart') &&
  //   //     event.type == FileSystemEvent.modify) {
  //   //   generator.main();
  //   // }
  // });
}
