import 'package:city_weather/core/error/failure.dart';
import 'package:city_weather/features/city_weather/domain/entities/weather.dart';
import 'package:city_weather/features/city_weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase {
  // define repositories that will be used
  final WeatherRepository weatherRepository;
  GetCurrentWeatherUseCase(this.weatherRepository);

  // create an method to execute the weatherRepository.getCurrentWeather with cityName params.
  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
