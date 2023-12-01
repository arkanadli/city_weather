import 'package:city_weather/core/constants/constants.dart';
import 'package:city_weather/core/error/exception.dart';
import 'package:city_weather/features/city_weather/data/data_sources/remote/remote_data_source.dart';
import 'package:city_weather/features/city_weather/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;

  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'New York';

  group('get current weather', () {
    test('return a valid weather model when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByCityName(testCityName),
          ),
        ),
      ).thenAnswer((_) async => http.Response(
          readJson('helpers/dummy_data/dummy_weather_response.json'), 200));
      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      // assert
      expect(result, isA<WeatherModel>());
    });

    test('throw the server exception handling when the status code is not 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByCityName(testCityName),
          ),
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 400));
      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      // assert
      expect(result, isA<ServerException>());
    });
  });
}
