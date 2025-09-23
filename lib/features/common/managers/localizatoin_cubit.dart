import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit({
    required String locale,
  }) : locals = locale,
       super(Locale(locale));
  String locals;
  final prefs = SharedPreferencesAsync();

  Future<void> changeLocale({required String locale}) async {
    await prefs.setString("locale", locale);
    emit(Locale(locale,locals = locale));
  }
}
