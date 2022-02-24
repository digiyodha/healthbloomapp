import 'package:health_bloom/services/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceStore {
  SharedPreferences _prefs;

  DeviceStore(this._prefs);

  Future<bool> saveString(String key, String value) async {
    Logger.log("Saving String to device. key=$key, value=$value");
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      Logger.log("Could not save to storage. key=$key, value=$value");
      return null;
    }
  }

  Future<String> getString(String key) async {
    Logger.log("Retrieving String from device. key=$key");
    try {
      String value = _prefs.getString(key);
      Logger.log("Successful retrieval for key=$key. value=$value");
      return value;
    } catch (e) {
      Logger.log("No value for key=$key");
      return null;
    }
  }

  Future<bool> remove(String key) async {
    Logger.log("Clearing saved value for key. key=$key");
    try {
      return await _prefs.remove(key);
    } catch (e) {
      Logger.log("Failed to remove value for key. key=$key");
      return null;
    }
  }
}
