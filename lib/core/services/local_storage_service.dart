// lib/core/services/local_storage_service.dart

import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String eventBox =
      'events_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isBoxOpen(eventBox)) {
      await Hive.openBox(eventBox);
    }
  }

  static Box getBox() {
    return Hive.box(eventBox);
  }
}