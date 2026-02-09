import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final GetStorage _storage = GetStorage();
  static const _accessToken = "access_token";
  static const _email = "email";
  static const _mobile = "mobile";
  static const _isFistRun = "isFirstRun";
  static const _firstName = "first_name";
  static const _last_name = "last_name";
  static const _profileUrl = "profile_url";
  static const _selectedAddress = "selected_address";
  static const _selectedAddressDetails = "selected_address_details";
  static const _roles = "roles";

  //Added userId
  static const _uid = "uid";
  static const _points = "points";

  // Add these methods to LocalStorage class
  static void setUid(String val) => _storage.write(_uid, val);
  static String getUid() => _storage.read(_uid) ?? "";

  static void setPoints(int val) => _storage.write(_points, val);
  static int getPoints() => _storage.read(_points) ?? 0;

  //Write And read List
  /// Save list (String / int / Map)
  static void saveList(String key, List value) {
    _storage.write(key, value);
  }

  static void saveString(String key, String value) {
    _storage.write(key, value);
  }

  static String? getString(String key) {
    return _storage.read(key);
  }

  static List<dynamic>? readList(String key) {
    final data = _storage.read(key);
    if (data == null) return null;
    return List<dynamic>.from(data);
  }

  /// Read List<String>
  static List<String>? getStringList(String key) {
    final data = _storage.read(key);
    if (data == null) return null;
    return List<String>.from(data);
  }

  static Future<void> deleteAllLocalData() async {
    await _storage.erase();
  }

  static void clearLogInSession() {
    _storage.remove(_accessToken);
    _storage.remove(_email);
    _storage.remove(_firstName);
    _storage.remove(_last_name);
    _storage.remove(_mobile);
    _storage.remove(_roles);
    _storage.remove(_selectedAddress);
    _storage.remove(_selectedAddressDetails);
  }

  ///set Data in local Storage

  static Future<void> setAccessToken(String val) async {
    await _storage.write(_accessToken, val);
  }

  /// Setter Methods
  static void setEmail(String val) {
    _storage.write(_email, val);
  }

  static void setAddress(String val) {
    _storage.write(_selectedAddress, val);
  }

  static void setAddressDetails(String val) {
    _storage.write(_selectedAddressDetails, val);
  }

  static void setFirstRun(bool val) {
    _storage.write(_isFistRun, val);
  }

  static void setRoles(List<String> val) {
    _storage.write(_roles, val);
  }

  static void setFirstName(String val) {
    _storage.write(_firstName, val);
  }

  static void setLastName(String val) {
    _storage.write(_last_name, val);
  }

  static void setMobileNo(String val) {
    _storage.write(_mobile, val);
  }

  static void setProfileUrl(String val) {
    _storage.write(_profileUrl, val);
  }

  /// Getter Methods
  static String getEmail() {
    return _storage.read(_email) ?? "";
  }

  static String getFirstName() {
    return _storage.read(_firstName) ?? "";
  }

  static String getLastName() {
    return _storage.read(_last_name) ?? "";
  }

  static String getMobileNo() {
    return _storage.read(_mobile) ?? "";
  }

  static String getSelectedAddress() {
    return _storage.read(_selectedAddress) ?? "";
  }

  static String getSelectedAddressDetails() {
    return _storage.read(_selectedAddressDetails) ?? "";
  }

  static bool getFirstRun() {
    return _storage.read(_isFistRun) ?? true;
  }

  static List<String> getRoles() {
    final list = _storage.read(_roles) ?? [];
    return List<String>.from(list);
  }

  static String getProfileUrl() {
    return _storage.read(_profileUrl) ?? "";
  }

  static String getAccessToken() {
    return _storage.read(_accessToken) ?? "";
  }
}
