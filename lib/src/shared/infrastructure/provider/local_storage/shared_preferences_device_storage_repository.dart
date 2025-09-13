import 'package:teslo_app/src/shared/infrastructure/provider/local_storage/device_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDeviceStorageRepository
    implements DeviceStorageRepository {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case String:
        return prefs.getString(key) as T?;
      default:
        throw UnimplementedError(
          'GET not implemented for type ${T.runtimeType}',
        );
    }
  }

  @override
  Future<void> setValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      default:
        throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}',
        );
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }
}
