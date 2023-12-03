import 'package:city_weather/features/city_weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
  });
}
