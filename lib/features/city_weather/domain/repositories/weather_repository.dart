import 'package:city_weather/core/error/failure.dart';
import 'package:city_weather/features/city_weather/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  // create a method that weather repository impl in data layer must have
  // create either it is successfull<right> or failure<left> in future process
  // we must create the error class handler in folder core
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
