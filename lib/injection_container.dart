import 'package:city_weather/features/city_weather/data/data_sources/remote/remote_data_source.dart';
import 'package:city_weather/features/city_weather/data/repositories/weather_repository_impl.dart';
import 'package:city_weather/features/city_weather/domain/repositories/weather_repository.dart';
import 'package:city_weather/features/city_weather/domain/usecases/get_current_weather.dart';
import 'package:city_weather/features/city_weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

// this is the setup that will be run whenever the application start
void setupLocator() {
  // setup bloc with registerFactory, because we will dispose and creating this in other pages
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()));

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
