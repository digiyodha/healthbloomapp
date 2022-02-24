import 'device_store.dart';

class UserStoreManager {
  static const String userKey = "user";
  static const String userAvatarKey = "avatar";
  static const String userNameKey = "name";

  DeviceStore _deviceStore;

  UserStoreManager(this._deviceStore);

  Future<String> getUser() async {
    try {
      String userJson = await _deviceStore.getString(userKey);
      if (userJson != null) {
        return userJson;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> getUserAvatar() async {
    try {
      String userJson = await _deviceStore.getString(userAvatarKey);
      if (userJson != null) {
        return userJson;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> getUserName() async {
    try {
      String userJson = await _deviceStore.getString(userNameKey);
      if (userJson != null) {
        return userJson;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveUser(
      String userID, String avatar, String patientName) async {
    bool userSaved = await _deviceStore.saveString(userKey, userID);
    bool userAvatarSaved = await _deviceStore.saveString(userAvatarKey, avatar);
    bool userNameSaved =
        await _deviceStore.saveString(userNameKey, patientName);

    return (userSaved && userAvatarSaved && userNameSaved);
  }

  Future<bool> deleteUser() async {
    bool userSaved = await _deviceStore.remove(userKey);
    bool userAvatarSaved = await _deviceStore.remove(userAvatarKey);
    bool userNameSaved = await _deviceStore.remove(userNameKey);
    return (userSaved && userAvatarSaved && userNameSaved);
  }
}
