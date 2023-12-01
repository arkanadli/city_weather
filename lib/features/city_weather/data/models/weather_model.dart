import 'package:city_weather/features/city_weather/domain/entities/weather.dart';
import 'package:flutter/material.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required String cityName,
      required String main,
      required String description,
      required String iconCode,
      required double temperature,
      required int pressure,
      required int humidity})
      : super(
          cityName: cityName,
          main: main,
          description: description,
          iconCode: iconCode,
          temperature: temperature,
          pressure: pressure,
          humidity: humidity,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['name'],
        main: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        iconCode: json['weather'][0]['icon'],
        temperature: json['main']['temp'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
      );

  Map<String, dynamic> toJson() => {
        'name': cityName,
        'weather': [
          {'main': main, 'description': description, 'icon': iconCode}
        ],
        'main': {
          'temp': temperature,
          'pressure': pressure,
          'humidity': humidity
        }
      };
}
