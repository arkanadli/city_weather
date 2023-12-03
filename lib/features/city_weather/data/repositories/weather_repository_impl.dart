import 'dart:io';

import 'package:city_weather/core/error/exception.dart';
import 'package:city_weather/core/error/failure.dart';
import 'package:city_weather/features/city_weather/data/data_sources/remote/remote_data_source.dart';
import 'package:city_weather/features/city_weather/domain/entities/weather.dart';
import 'package:city_weather/features/city_weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      final resultEntity = result.toEntity();
      return Right(resultEntity);
    } on ServerException {
      return const Left(
        ServerFailure('An Error has occured'),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Socket Connection failed to connect!'),
      );
    }
  }
}
