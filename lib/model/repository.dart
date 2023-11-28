import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/system_util.dart';

class Repository {
  final localApi = LocalAPI();

  getPath() => localApi.getPath();

  setPath(String path) => localApi.setPath(path);

  getWeather() => localApi.getWeather();

  getDday() => localApi.getDday();

  setWeather(bool weather) => localApi.setWeather(weather);

  setDday(bool dday) => localApi.setDday(dday);

  getDdayDateTime() => localApi.getDdayDateTime();

  setDdayDateTime(DateTime date) => localApi.setDdayDateTime(date);

  getScale() => localApi.getScale();

  updateScale(double value) => localApi.updateScale(value);
}

typedef onSuccess = void Function(dynamic);
typedef onFail = void Function(dynamic);

class LocalAPI {
  late SharedPreferences sharedPreferences;

  Future<bool> getWeather() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool? isWeather = sharedPreferences.getBool('Weather');
    return isWeather ?? true;
  }

  Future<bool> setWeather(bool weather) async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool isSuccess = await sharedPreferences.setBool('Weather', weather);
    return isSuccess;
  }

  Future<bool> getDday() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool? isDday = sharedPreferences.getBool('Dday');
    return isDday ?? true;
  }

  Future<bool> setDday(bool dday) async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool isSuccess = await sharedPreferences.setBool('Dday', dday);
    return isSuccess;
  }

  Future<String> getPath() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? path = sharedPreferences.getString('Path');
    if (path == null) {
      return '';
    } else {
      return path;
    }
  }

  Future<bool> setPath(String path) async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool isSuccess = await sharedPreferences.setString('Path', path);
    return isSuccess;
  }

  getDdayDateTime() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? dateTime = await sharedPreferences.getString('DateTime');
    if (dateTime == null) {
      return DateTime(2024, 2, 4);
    } else {
      return DateTime.parse(dateTime);
    }
  }

  setDdayDateTime(DateTime date) async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool isSuccess = await sharedPreferences.setString(
        'DateTime', DateFormat('yyyyMMdd').format(date));
    return isSuccess;
  }

  getScale() async {
    sharedPreferences = await SharedPreferences.getInstance();
    double? scale = await sharedPreferences.getDouble('Scale');
    return scale ?? 0;
  }

  updateScale(double value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool isSuccess = await sharedPreferences.setDouble('Scale', value);
    return isSuccess;
  }
}
