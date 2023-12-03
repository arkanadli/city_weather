import 'package:city_weather/core/error/exception.dart';
import 'package:city_weather/core/error/failure.dart';
import 'package:city_weather/features/city_weather/data/models/weather_model.dart';
import 'package:city_weather/features/city_weather/data/repositories/weather_repository_impl.dart';
import 'package:city_weather/features/city_weather/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 277.62,
    pressure: 1021,
    humidity: 71,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 277.62,
    pressure: 1021,
    humidity: 71,
  );

  const testCityName = 'New York';

  group(
    'get current weather',
    () {
      test('first scenario, getting data successfully from api', () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenAnswer(
          (_) async {
            return testWeatherModel;
          },
        );
        // act
        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);
        // expect
        expect(result, equals(const Right(testWeatherEntity)));
      });

      test(
          'second scenario, getting Failure from failed collectin data from api',
          () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(ServerException());
        // act
        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);
        // expect
        expect(
            result, equals(const Left(ServerFailure('An Error has occured'))));
      });
      test(
          'third scenario, getting Failure from no connection from user internet socket',
          () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(SocketException());
        // act
        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);
        // expect
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Socket Connection failed to connect!'))));
      });
    },
  );
}
