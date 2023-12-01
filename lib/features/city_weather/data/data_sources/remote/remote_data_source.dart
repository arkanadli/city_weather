import 'dart:convert';

import 'package:city_weather/core/constants/constants.dart';
import 'package:city_weather/core/error/exception.dart';
import 'package:city_weather/core/error/failure.dart';
import 'package:city_weather/features/city_weather/data/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByCityName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
