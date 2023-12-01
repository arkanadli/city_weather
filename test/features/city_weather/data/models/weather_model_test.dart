import 'dart:convert';

import 'package:city_weather/features/city_weather/data/models/weather_model.dart';
import 'package:city_weather/features/city_weather/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  setUp(() {});

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 277.62,
    pressure: 1021,
    humidity: 71,
  );

  const expectedJsonModel = {
    'name': 'New York',
    'weather': [
      {'main': 'Clear', 'description': 'clear sky', 'icon': '01n'}
    ],
    'main': {'temp': 277.62, 'pressure': 1021, 'humidity': 71}
  };

  test('should be a subclass of weather entity (weather model)', () async {
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers\\dummy_data\\dummy_weather_response.json'),
    );
    // act
    final resultModel = WeatherModel.fromJson(jsonMap);
    // expect
    expect(resultModel, equals(testWeatherModel));
  });

  test('should return a valid json model', () async {
    // act
    final jsonModel = testWeatherModel.toJson();
    // expect
    expect(jsonModel, equals(expectedJsonModel));
  });
}
