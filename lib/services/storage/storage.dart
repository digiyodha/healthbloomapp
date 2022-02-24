import 'package:shared_preferences/shared_preferences.dart';

import 'device_store.dart';
import 'user_store_manager.dart';

export 'package:shared_preferences/shared_preferences.dart';

export 'device_store.dart';
export 'user_store_manager.dart';

DeviceStore _deviceStore;
Future<DeviceStore> getDeviceStore() async {
  if (_deviceStore == null) {
    _deviceStore = DeviceStore(await SharedPreferences.getInstance());
  }
  return _deviceStore;
}

UserStoreManager _userStoreManager;
Future<UserStoreManager> getUserStoreManager() async {
  if (_userStoreManager == null) {
    _userStoreManager = UserStoreManager(await getDeviceStore());
  }
  return _userStoreManager;
}
