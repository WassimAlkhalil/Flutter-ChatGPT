import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Mode {
  final ligttheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(),
  );

  final darktheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(),
  );

  final getStorage = GetStorage();
  final darkThemeKey = 'darkTheme';

  void saveThemeData(bool darkTheme) =>
      getStorage.write(darkThemeKey, darkTheme);

  bool isSavedDarkMode() => getStorage.read(darkThemeKey) ?? false;

  ThemeMode getThemeMode() =>
      isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}
