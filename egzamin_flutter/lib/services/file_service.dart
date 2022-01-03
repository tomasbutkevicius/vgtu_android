import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {
  Future<File> write(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(data);
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return "Error reading file";
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/egzas.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}