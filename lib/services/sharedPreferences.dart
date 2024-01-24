import 'package:shared_preferences/shared_preferences.dart';

sealed class ModeAndLocalization {
 static void addToSharedPref({required String key, required var value}) async {
    // Shared Pref instanse
    var sharedPref = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case int:
        // Save an [integer] value to given [key].
        await sharedPref.setInt(key, value);
        break;
      case bool:
        // Save an [Boolean] value to given [key].
        await sharedPref.setBool(key, value);
        break;
      case double:
        // Save an [Double] value to given [key].
        await sharedPref.setDouble(key, value);
        break;
      case String:
        // Save an [String] value to given [key].
        await sharedPref.setString(key, value);
        break;
      case const (List<String>):
        // Save an [List of Strings] value to given [key].
        await sharedPref.setStringList(key, value);
        break;
      default:
        print("You cannot set other types to Shared Preferance");
    }
  }

  // Read From Shared Pref
 static  readFromSharedPref(String key, Type type) async {
    var sharedPref = await SharedPreferences.getInstance();

    // Read Data
    switch (type) {
      case int:
      // Read an [integer] value from given [key].
        return sharedPref.getInt(key);

      case bool:
      // Read an [Boolean] value from given [key].
        return sharedPref.getBool(key);

      case double:
      // Read an [Double] value from given [key].
        return sharedPref.getDouble(key);

      case String:
      // Read an [String] value from given [key].
        return sharedPref.getString(key);

      case const (List<String>):
      // Read an [List of Strings] value from given [key].
        return sharedPref.getStringList(key);
    }
  }
  // Delete From Shared Pref
 static  deleteFromSharedPref(String key) async {

    // Shared Pref instanse
    var sharedPref = await SharedPreferences.getInstance();

    await sharedPref.remove(key);
  }

 static updateDataInSharedPref({required String key, required var value}) async {
    // Shared Pref instanse
    var sharedPref = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case int:
      // Update an [integer] value to given [key].
        await sharedPref.setInt(key, value);
        break;
      case bool:
      // Update a [Boolean] value to given [key].
        await sharedPref.setBool(key, value);
        break;
      case double:
      // Update a [Double] value to given [key].
        await sharedPref.setDouble(key, value);
        break;
      case String:
      // Update a [String] value to given [key].
        await sharedPref.setString(key, value);
        break;
      case const (List<String>):
      // Update a [List of Strings] value to given [key].
        await sharedPref.setStringList(key, value);
        break;

    }
  }
}
