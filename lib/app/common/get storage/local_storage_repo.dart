import 'package:get_storage/get_storage.dart';

class LocalStorageRepo {
  static LocalStorageRepo get instance => LocalStorageRepo();
  final box = GetStorage();

  void writeData({
    required String key,
    required dynamic value,
  }) {
    box.write(key, value);
  }

  readData({required String key}) {
    return box.read(key);
  }
}
