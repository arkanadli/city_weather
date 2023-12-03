import 'package:city_weather/features/city_weather/data/data_sources/remote/remote_data_source.dart';
import 'package:city_weather/features/city_weather/domain/repositories/weather_repository.dart';
import 'package:city_weather/features/city_weather/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [WeatherRepository, WeatherRemoteDataSource, GetCurrentWeatherUseCase],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {

}
