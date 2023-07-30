import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  late final BoxCollection collections;
  void init() async {
    try {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      await BoxCollection.open(
        'marketplace', // Name of your database
        { 
          'purchased',  // Names of your boxes
          'carts',  // Names of your boxes
        },
        path: appDocDirectory.path,
        // path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
        // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
      );
    } catch (e) {
      log('InitHive Catch $e');
    }
  }
}
