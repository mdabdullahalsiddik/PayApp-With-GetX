import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final getStorage = GetStorage();
  final storageKey = "isDarkMode";
  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    return getStorage.read(storageKey) ?? false;
  }

  saveThemeMode(bool isDarkMode) {
    getStorage.write(storageKey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeTheme(isSavedDarkMode() ? ThemeData.light() : ThemeData.dark());
    saveThemeMode(!isSavedDarkMode());
  }
}
