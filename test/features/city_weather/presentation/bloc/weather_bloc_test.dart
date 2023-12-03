import 'package:city_weather/core/error/failure.dart';
import 'package:city_weather/features/city_weather/domain/entities/weather.dart';
import 'package:city_weather/features/city_weather/presentation/bloc/weather_bloc.dart';
import 'package:city_weather/features/city_weather/presentation/bloc/weather_event.dart';
import 'package:city_weather/features/city_weather/presentation/bloc/weather_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

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

  group('On Changed City', () {
    test('initial state should be empty', () async {
      // expect
      expect(weatherBloc.state, WeatherEmpty());
    });

    blocTest(
      'state should be DataLoading and DataLoaded when data successfully get',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName))
            .thenAnswer((_) async => const Right(testWeatherEntity));
        return weatherBloc; // it return weatherBloc so that the act know that this is talking about weatherBloc
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), const WeatherLoaded(testWeatherEntity)],
    );
    blocTest(
      'state should be DataLoading and DataLoadFailure when data failure ',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return weatherBloc; // it return weatherBloc so that the act know that this is talking about weatherBloc
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        const WeatherLoadFailure(errorMessage: 'Server Failure')
      ],
    );
  });
}
